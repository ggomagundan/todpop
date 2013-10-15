class CpdAdvertisement < ActiveRecord::Base
  
  KIND={
     :IMAGE => 1,
     :COUPON => 2
  }
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader

  after_create do |ad|
    ad.update_attributes(:remain => ad.count)          
  end

  def ad_type
   return CpdAdvertisement::KIND.key(self.kind)
  end


  
end
