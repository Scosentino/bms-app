class NavbarLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
