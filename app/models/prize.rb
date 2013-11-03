# -*- encoding : utf-8 -*-
class Prize < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  def period_str
    if self.period.blank?
      return ""
    end
    if self.period == 1
      return "week"
    elsif self.period == 2
      return "month"
    end

  end
end
