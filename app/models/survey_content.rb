class SurveyContent < ActiveRecord::Base

	belongs_to :cpx_advertisement
	mount_uploader :q_image, ImageUploader
	Q_TYPE={
    :CPS_SPEC => 0,
    :NO_IMAGE_CHOICE_ANSWER => 1,
    :IMAGE_CHOICE_ANSWER => 2,
    :NO_IMAGE_SHORT_ANSWER => 3,
    :IMAGE_SHORT_ANSWER => 4
  }
  def kind
   return SurveyContent::Q_TYPE.key(self.q_type)
  end
end
