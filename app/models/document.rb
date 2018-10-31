class Document < ApplicationRecord
  has_paper_trail

  belongs_to :documentable, polymorphic: true, optional: true
  has_attached_file :fyle, PAPERCLIP_OPTIONS
  validates_attachment_content_type :fyle, PAPERCLIP_CONTENT_VALIDATION[:image_video_pdf]
  validates :fyle, presence: true

  def video?
    fyle.content_type.include?('video')
  end

  def image?
    fyle.content_type.include?('image')
  end

  def pdf?
    fyle.content_type.include?('pdf')
  end

  def get_styles(column_name)
    if image?
      { large: '700x450>', medium: '300x225>' }
    elsif video?
      {
        thumb: { geometry: "600x600#", format: 'jpg', time: 2 },
        webm: { format: 'webm' },
        mp4: { format: 'mp4' }
      }
    elsif pdf?
      { large: '700x450>', medium: '300x225>' }
    end
  end

  def get_processor
    case
    when image?
      [:thumbnail]
    when video?
      [:transcoder]
    when pdf?
      [:thumbnail]
    end
  end
end
