class CpdmAdvertisement < ActiveRecord::Base

	has_many :advertise_cpdm_logs
	mount_uploader :video, VideoUploader

  AD_TYPE={
    :CPDM => 201,
    :CPFS_movie => 202
  }
  
  PAY_TYPE = {
    :PAY_ADVANCE => 1,
    :PAY_LATER =>2
  }

  after_create do |ad|
    ad.update_attributes(:remain => ad.contract)
    if ad.video.file.present?
    	ad.update_attributes(:url => ad.video_url)
    end
  end

  def kind
    return CpdmAdvertisement::AD_TYPE.key(self.ad_type)
  end

  def pay_kind
    return CpdAdvertisement::PAY_TYPE.key(self.pay_type)
  end
end
