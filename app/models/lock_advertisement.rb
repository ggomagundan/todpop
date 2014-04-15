class LockAdvertisement < ActiveRecord::Base
  
  has_many :advertise_lock_logs

  AD_TYPE={
    :IMAGE => 101,
    :COUPON => 102,
    :CPFS_img => 103
  }
  PAY_TYPE = {
    :PAY_ADVANCE => 1,
    :PAY_LATER =>2
  }
  
  mount_uploader :ad_image, ImageUploader
  
  def kind
   return CpdAdvertisement::AD_TYPE.key(self.ad_type)
  end

  def pay_kind
    return CpdAdvertisement::PAY_TYPE.key(self.pay_type)
  end
end
