class DocumentsUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_whitelist
    %w(pdf jpg jpeg png)
  end
end
