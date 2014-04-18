class LockAdvertisement < ActiveRecord::Base
  
  has_many :advertise_lock_logs

  AD_TYPE={
    :CPC => 401,
  }
  PAY_TYPE = {
    :PAY_ADVANCE => 1,
    :PAY_LATER =>2
  }
  
  mount_uploader :ad_image, ImageUploader
  
  def kind
   return LockAdvertisement::AD_TYPE.key(self.ad_type)
  end

  def pay_kind
    return LockAdvertisement::PAY_TYPE.key(self.pay_type)
  end
end
