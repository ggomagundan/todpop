class CpxAdvertisement < ActiveRecord::Base

 KIND={
     :CPI  => 3,
     :CPL => 4,
     :CPA => 5,
     :CPE => 6,
     :CPS => 7,
     :CPC => 8
  }

  after_create do |ad|
    ad.update_attributes(:remain => ad.count)          
    ad.update_attributes(:end_time => ad.start_time + 90.days)
  end

  def ad_type
   return CpxAdvertisement::KIND.key(self.kind)
  end



end
