class UserSerializer < ApplicationSerializer
  attributes :id, :email, :provider, :name, :gplus_profile, :facebook_profile,
             :twitter_profile, :linkedin_profile, :username, :country_id,
             :description, :profile_pic, :educations, :certificates, :availability_type,
             :languages, :status, :created_at, :updated_at

  has_many :posted_jobs
  has_many :reviews
  has_many :favourite_collections
  has_many :favourites
  has_many :followers
  has_many :bought_orders
  has_many :sold_orders
  has_many :payment_transactions
  has_many :skills_users
  has_many :skills
  has_one :country
  has_many :roles
  has_many :permissions

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :email, :provider, :name, :gplus_profile, :facebook_profile,
     :twitter_profile, :linkedin_profile, :username, :country_id,
     :description, :profile_pic, :educations, :certificates, :availability_type,
     :languages, :status, :created_at, :updated_at]
  end
end
