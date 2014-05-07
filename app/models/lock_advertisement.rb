class LockAdvertisement < ActiveRecord::Base
  
  has_many :advertise_lock_logs

  AD_TYPE={
    :짭영제출문제 => 412,
    :오늘의인강 => 421,
    :짤강 => 422,
    :헤럴드뉴스 => 431,
    :데일리뉴스 => 432,
    :수능정보 => 433,
    :웹툰 => 434,
    :짭영캠페인 => 441,
    :광고 => 442,
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
