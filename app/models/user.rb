class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, omniauth_providers: [:twitter, :facebook, :google_oauth2, :linkedin]

  has_paper_trail

  enum status: {
    verified: 'verified',
    unverified: 'unverified'
  }

  enum level: {
    beginner: 'beginner',
    intermediate: 'intermediate',
    expert: 'expert'
  }

  enum provider: {
    facebook: 'facebook',
    google_oauth2: 'google_oauth2',
    twitter: 'twitter',
    linkedin: 'linkedin',
    email: 'email'
  }

  enum availability_type: {
    part: 'part',
    full: 'full'
  }

  attr_accessor :confirm_password

  has_many :jobs
  has_many :reviews, foreign_key: 'reviewer_id'
  has_many :favourite_collections
  has_many :favourites, through: :favourite_collections
  has_many :followers, class_name: 'Favourite', as: :favourable
  has_many :bought_orders, foreign_key: 'buyer_id', class_name: 'Order'
  has_many :sold_orders, foreign_key: 'seller_id', class_name: 'Order'
  has_many :payment_transactions
  has_many :skills_users
  has_many :skills, through: :skills_users
  has_many :performed_actions, class_name: 'ActionLog', foreign_key: 'performer_id'
  has_many :action_logs, as: :actionable
  belongs_to :country, optional: true
  has_attached_file :profile_pic, PAPERCLIP_OPTIONS
  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles

  validates_attachment_content_type :profile_pic, PAPERCLIP_CONTENT_VALIDATION[:image]
  validates_presence_of :name, :email, :provider, :level, :status, :username
  validate :email_uniqueness, on: :create
  validate :password_same_as_confirm_password, on: :create

  before_validation :init

  def get_styles(column_name)
    { large: '700x450>', medium: '300x225>', chat_icon: '55x55>' }
  end

  def get_processor
    [:thumbnail]
  end

  def init
    self.level ||= :beginner
    self.provider ||= :email
    self.status ||= :verified
    self.gplus_profile ||= gplus_profile
    self.facebook_profile ||= facebook_profile
    self.twitter_profile ||= twitter_profile
    self.linkedin_profile ||= linkedin_profile
    self.username ||= generate_unique_user_name
    self.token_expires_at ||= 60.days.from_now
  end

  def generate_unique_user_name
    existing_usernames = self.class.pluck(:username)
    assigned_username = self.name.parameterize
    while existing_usernames.include?(assigned_username)
      assigned_username = assigned_username + ('A'..'Z').to_a.sample
    end
    assigned_username
  end

  def profile_pic_from_url=(url)
    self.profile_pic = open(url)
  end

  def self.find_for_create_auth_user(params, current_user)
    return current_user if current_user.present?
    @user = User.find_by(email: params[:email])
    if @user.present?
      @user.update_attributes(params)
      return @user
    end
    User.create(params)
  end

  def self.find_by_email_password(email:, password:)
    user = find_by(email: email)
    if user.present? && user.valid_password?(password)
      user
    end
  end

  def logged_in_with_social_platform?
    [:facebook, :google_oauth2, :twitter, :linkedin].include?(self.provider)
  end

  #
  # Add given role to user
  # @param role [Role] Role
  #
  def add_role(role)
    return if self.roles.exists?(role.id)
    self.roles << role
  end

  #
  # Remove given role from user
  # @param role [Role] Role
  #
  def remove_role(role)
    self.roles.destroy(role)
  end

  def generate_jwt(expiry = 60.days.from_now.to_i)
    JWT.encode(
      { id: id, exp: expiry },
      Rails.application.secrets.secret_key_base
    )
  end

  def permissions_given
    role_ids = roles.includes(:children)
                     .map(&:self_and_descendants)
                     .flatten
                     .map(&:id)

    Permission.joins(:roles)
              .where(roles: { id: role_ids })
              .distinct
  end

  private

  def email_uniqueness_append_message
    logged_in_with_social_platform? ? "using #{platform}." : '.'
  end

  def password_same_as_confirm_password
    if self.password != self.confirm_password
      self.errors.add('Confirm Password', 'should match with password')
    end
  end

  def email_uniqueness
    existing_emails = self.class.pluck(:email)
    if existing_emails.include?(self.email)
      self.errors.add('Email',  "Already Signed Up with this email#{email_uniqueness_append_message}")
    end
  end
end
