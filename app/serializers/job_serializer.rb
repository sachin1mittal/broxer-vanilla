class JobSerializer < ApplicationSerializer
  attributes :id, :category_id, :user_id, :title, :message_for_client,
             :description, :status, :faqs, :admin_status, :order_limit,
             :banner, :created_at, :updated_at

  has_many :documents
  has_many :jobs_metadatas
  has_many :packages
  has_many :followers
  has_many :spam_reports
  has_many :reviews
  has_many :tags
  belongs_to :category
  belongs_to :user
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :category_id, :user_id, :title, :message_for_client,
     :description, :status, :faqs, :admin_status, :order_limit,
     :banner, :created_at, :updated_at]
  end
end
