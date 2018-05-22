class DocumentsUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
