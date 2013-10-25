class CpdmAdvertisement < ActiveRecord::Base

	has_many :advertise_cpdm_logs
	mount_uploader :video, VideoUploader
  after_create do |ad|
    ad.update_attributes(:remain => ad.contract)
    if ad.video.file.present?
    	ad.update_attributes(:url => ad.video_url)
    end
  end
end
