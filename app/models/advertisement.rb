class Advertisement < ActiveRecord::Base

  has_many :advertise_logs


  AD_TYPE={
     :CPL => 0,
     :CPD => 1,
     :CPDM => 2,
     :CPI => 3,
     :CPA => 4
   }
   
  def ad_type
   return Advertisement::AD_TYPE.key(self.kind)
  end

end
