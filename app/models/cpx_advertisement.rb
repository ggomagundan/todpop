class CpxAdvertisement < ActiveRecord::Base

  has_many :advertise_cpx_logs
  AD_TYPE={
     :CPI => 301,
     :CPL => 302,
     :CPA => 303,
     :CPE => 304,
     :CPS => 305,
     :CPC => 306
  }
  mount_uploader :ad_image, ImageUploader

  after_create do |ad|
    ad.update_attributes(:remain => ad.count)          
    ad.update_attributes(:end_date => ad.start_time + 90.days)
  end

  def kind
   return CpxAdvertisement::KIND.key(self.ad_type)
  end



end
