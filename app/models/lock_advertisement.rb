class LockAdvertisement < ActiveRecord::Base
  
  has_many :advertise_lock_logs

  AD_GROUP={
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
  AD_TYPE={
    :IMAGE => 101,
    :COUPON => 102,
    :CPFS_img => 103,
    :CPDM => 201,
    :CPFS_movie => 202,
    :CPI => 301,
    :CPL => 302,
    :CPA => 303,
    :CPE => 304,
    :CPS => 305,
    :CPC => 306,
    :WORD_TEST => 400
  }
  
  mount_uploader :ad_image, ImageUploader
  mount_uploader :reserve_image, ImageUploader
  
  def ad_kind
    return LockAdvertisement::AD_TYPE.key(self.ad_type)
  end

  def kind
   return LockAdvertisement::AD_GROUP.key(self.group)
  end

  def pay_kind
    return LockAdvertisement::PAY_TYPE.key(self.pay_type)
  end
end
