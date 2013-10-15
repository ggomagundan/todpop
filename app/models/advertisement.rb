# -*- encoding : utf-8 -*-
class Advertisement < ActiveRecord::Base

  has_many :advertise_logs


  AD_TYPE={
     :CPD => 1,
     :CPDM => 2,
     :CPI => 3,
     :CPA => 4,
     :CPL => 5
   }


  after_create do |ad|
    ad.update_attributes(:remain => ad.count)          
  end

  def ad_type
   return Advertisement::AD_TYPE.key(self.kind)
  end

end
