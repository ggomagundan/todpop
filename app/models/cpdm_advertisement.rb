class CpdmAdvertisement < ActiveRecord::Base

	has_many :advertise_cpdm_logs
  after_create do |ad|
    #ad.update_attributes(:remain => ad.count)          
  end

end
