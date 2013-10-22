class CpdAdvertisement < ActiveRecord::Base
  
  has_many :advertise_cpd_logs

  AD_TYPE={
     :IMAGE => 101,
     :COUPON => 102
  }
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader

  after_create do |ad|
    ad.update_attributes(:remain => ad.count)          
  end

  def kind
   return CpdAdvertisement::AD_TYPE.key(self.ad_type)
  end

end
