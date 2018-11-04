class User < ApplicationRecord
  has_paper_trail

  enum status: {
    verified: 'verified',
    unverified: 'unverified'
  }

  enum provider: {
    facebook: 'facebook',
    google: 'google',
    twitter: 'twitter',
    linkedin: 'linkedin',
    email: 'email'
  }

  enum availability_type: {
    part: 'part',
    full: 'full'
  }

  has_many :posted_jobs, class_name: 'Job'
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
  validates_presence_of :name, :email, :provider, :status, :username
  validates_uniqueness_of :email, :username

  before_validation :init

  ######## Paperclip Methods #############

  def get_styles(column_name)
    { large: '700x450>', medium: '300x225>', chat_icon: '55x55>' }
  end

  def get_processor
    [:thumbnail]
  end

  ######## Paperclip Methods Ends #############

  def init
    self.provider ||= :email
    self.status ||= :verified
  end

  def self.find_by_email_password!(email:, password:)
    user = find_by!(email: email)
    user.check_password!(password) && user
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
    Permission.joins(:roles)
              .where(roles: { id: self.role_ids })
              .distinct
  end

  def check_password!(password)
    if !Digest::SHA1.hexdigest(password) == self.encrypted_password
      raise ::Unauthorized.new('Incorrect Password')
    end
  end
end
