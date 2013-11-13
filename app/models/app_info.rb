# -*- encoding : utf-8 -*-
class AppInfo < ActiveRecord::Base
  mount_uploader :popup_image, ImageUploader
end
