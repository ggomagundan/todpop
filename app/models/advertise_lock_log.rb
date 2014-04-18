class AdvertiseLockLog < ActiveRecord::Base
	belongs_to :user
	belongs_to :lock_advertisement
end
