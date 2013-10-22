class SurveyContent < ActiveRecord::Base

	belongs_to :cpx_advertisement
	mount_uploader :q_image, ImageUploader
	Q_TYPE={
     :NO_IMAGE => 1,
     :IMAGE => 2,
     :NO_IMAGE_SINGLE => 3,
     :IMAGE_SINGLE => 4,
  }
  def kind
   return SurveyContent::Q_TYPE.key(self.q_type)
  end
end
