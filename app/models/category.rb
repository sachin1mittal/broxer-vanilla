class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category', foreign_key: 'parent_id', optional: true
  has_many :child_categories, class_name: 'Category', foreign_key: 'parent_id'
  has_many :benefits
  has_many :jobs
  has_many :metadatas

  has_attached_file :banner, PAPERCLIP_OPTIONS
  has_attached_file :logo, PAPERCLIP_OPTIONS
  validates_attachment_content_type :banner, PAPERCLIP_CONTENT_VALIDATION[:image]
  validates_attachment_content_type :logo, PAPERCLIP_CONTENT_VALIDATION[:image]

  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 1000, allow_nil: true }

  def get_styles(column_name)
    if column_name == :banner
      { large: '700x450>', medium: '300x225>' }
    elsif column_name == :logo
      { large: '700x450>', medium: '300x225>' }
    end
  end

  def get_processor
    [:thumbnail]
  end
end
