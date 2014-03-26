class CpxAdvertisement < ActiveRecord::Base

  has_many :advertise_cpx_logs
  has_many :survey_contents
  AD_TYPE={
     :CPI => 301,
     :CPL => 302,
     :CPA => 303,
     :CPE => 304,
     :CPS => 305,
     :CPC => 306,
     :default => 300
  }
  PAY_TYPE = {
    :PAY_ADVANCE => 1,
    :PAY_LATER =>2
  }
  mount_uploader :ad_image, ImageUploader

  after_create do |ad|
    ad.update_attributes(:remain => ad.contract)          
    #ad.update_attributes(:end_date => ad.start_date + 90.days)
  end

  def kind
   return CpxAdvertisement::AD_TYPE.key(self.ad_type)
  end

  def pay_kind
    return CpdAdvertisement::PAY_TYPE.key(self.pay_type)
  end
end
