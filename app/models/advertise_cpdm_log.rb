class AdvertiseCpdmLog < ActiveRecord::Base

	belongs_to :user
	belongs_to :cpdm_advertisement

end
