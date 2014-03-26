class CpdAdvertisement < ActiveRecord::Base
  
  has_many :advertise_cpd_logs

  AD_TYPE={
    :IMAGE => 101,
    :COUPON => 102,
    :FACEBOOK => 103,
  }
  PAY_TYPE = {
    :PAY_ADVANCE => 1,
    :PAY_LATER =>2
  }
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader

  after_create do |ad|
    ad.update_attributes(:remain => ad.contract)          
  end

  def kind
   return CpdAdvertisement::AD_TYPE.key(self.ad_type)
  end

  def pay_kind
    return CpdAdvertisement::PAY_TYPE.key(self.pay_type)
  end

end
