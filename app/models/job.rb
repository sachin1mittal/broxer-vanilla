class Job < ApplicationRecord
  has_paper_trail

  enum status: {
    draft: 'draft',
    posted: 'posted',
    inactive: 'inactive'
  }

  enum admin_status: {
    pending: 'pending',
    approved: 'approved',
    requires_modification: 'requires_modification',
    disapproved: 'disapproved'
  }

  has_many :documents, as: :documentable
  has_many :jobs_metadatas
  has_many :packages
  has_many :followers, class_name: 'Favourite', as: :favourable
  has_many :spam_reports, as: :reportable
  has_many :reviews, as: :reviewable
  has_many :tag_links, as: :taggable
  has_many :tags, through: :tag_links
  belongs_to :category
  belongs_to :user

  has_attached_file :banner, PAPERCLIP_OPTIONS
  validates_attachment_content_type :banner, PAPERCLIP_CONTENT_VALIDATION[:image]
  validates_presence_of :title, :description, :status, :admin_status

  def get_styles(column_name)
    { large: '700x450>', medium: '300x225>' }
  end

  def get_processor
    [:thumbnail]
  end
end
