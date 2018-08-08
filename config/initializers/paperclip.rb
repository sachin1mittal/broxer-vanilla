S3_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/s3.yml")).result).with_indifferent_access

PAPERCLIP_OPTIONS = {
  styles: lambda { |a| a.instance.get_styles(a.name) },
  processor: lambda { |a| a.get_processor },
  default_url: lambda { |a| "/system/#{a.instance.model_name.route_key}/#{a.name.to_s.pluralize}/:style/missing.png" }
}

unless Rails.env.development?
  PAPERCLIP_OPTIONS.merge!(
    storage: :s3,
    s3_region: S3_CONFIG['s3_region'],
    s3_credentials: S3_CONFIG['credentials'],
    path: ':attachment/:id/:style.:extension',
    bucket: S3_CONFIG['bucket']
  )
end

PAPERCLIP_CONTENT_VALIDATION = {
  image: {
    content_type: [
      'image/bmp','image/cis-cod', 'image/gif', 'image/ief', 'image/jpeg', 'image/jpg',
      'image/png', 'image/pipeg', 'image/svg+xml', 'image/tiff', 'image/tiff',
      'image/x-cmu-raster', 'image/x-cmx', 'image/x-icon', 'image/x-portable-anymap',
      'image/x-portable-bitmap', 'image/x-portable-graymap', 'image/x-portable-pixmap',
      'image/x-rgb', 'image/x-xbitmap', 'image/x-xpixmap', 'image/x-xwindowdump'
    ]
  },
  video: {
    content_type: [
      'application/x-mp4', 'application/mp4', 'video/mpeg', 'video/quicktime',
      'video/x-la-asf', 'video/x-ms-asf', 'video/x-msvideo', 'video/x-sgi-movie',
      'video/x-flv', 'flv-application/octet-stream', 'video/3gpp', 'video/3gpp2',
      'video/3gpp-tt', 'video/BMPEG', 'video/BT656', 'video/CelB', 'video/DV', 'video/H261',
      'video/H263', 'video/H263-1998', 'video/H263-2000', 'video/H264', 'video/JPEG',
      'video/MJ2', 'video/MP1S', 'video/MP2P', 'video/MP2T', 'video/mp4', 'video/MP4V-ES',
      'video/MPV', 'video/mpeg4', 'video/mp4', 'video/mpeg4-generic', 'video/nv',
      'video/parityfec', 'video/pointer', 'video/raw', 'video/rtx', 'video/vnd.objectvideo'
    ]
  },
  pdf: { content_type: ['application/pdf'] },
  image_video_pdf: {
    content_type: [
      'image/bmp','image/cis-cod', 'image/gif', 'image/ief', 'image/jpeg', 'image/jpg',
      'image/png', 'image/pipeg', 'image/svg+xml', 'image/tiff', 'image/tiff',
      'image/x-cmu-raster', 'image/x-cmx', 'image/x-icon', 'image/x-portable-anymap',
      'image/x-portable-bitmap', 'image/x-portable-graymap', 'image/x-portable-pixmap',
      'image/x-rgb', 'image/x-xbitmap', 'image/x-xpixmap', 'image/x-xwindowdump',
      'application/x-mp4', 'application/mp4', 'video/mpeg', 'video/quicktime',
      'video/x-la-asf', 'video/x-ms-asf', 'video/x-msvideo', 'video/x-sgi-movie',
      'video/x-flv', 'flv-application/octet-stream', 'video/3gpp', 'video/3gpp2',
      'video/3gpp-tt', 'video/BMPEG', 'video/BT656', 'video/CelB', 'video/DV', 'video/H261',
      'video/H263', 'video/H263-1998', 'video/H263-2000', 'video/H264', 'video/JPEG',
      'video/MJ2', 'video/MP1S', 'video/MP2P', 'video/MP2T', 'video/mp4', 'video/MP4V-ES',
      'video/MPV', 'video/mpeg4', 'video/mp4', 'video/mpeg4-generic', 'video/nv',
      'video/parityfec', 'video/pointer', 'video/raw', 'video/rtx', 'video/vnd.objectvideo',
      'application/pdf'
    ]
  }
}
