# -*- encoding : utf-8 -*-
class AppIntroduceVideo < ActiveRecord::Base
	mount_uploader :video, VideoUploader

	after_create do |row|
		if row.video.file.present?
			row.update_attributes(:url => row.video_url)
		end
	end
end
