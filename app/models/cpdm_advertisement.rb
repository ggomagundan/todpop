class CpdmAdvertisement < ActiveRecord::Base

  after_create do |ad|
    ad.update_attributes(:remain => ad.count)          
  end

end
