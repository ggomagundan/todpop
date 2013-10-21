require 'test_helper'

class Admin::AppIntroduceVideosControllerTest < ActionController::TestCase
  def test_edit
    get :edit, :id => AppIntroduceVideo.first
    assert_template 'edit'
  end

  def test_update_invalid
    AppIntroduceVideo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AppIntroduceVideo.first
    assert_template 'edit'
  end

  def test_update_valid
    AppIntroduceVideo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AppIntroduceVideo.first
    assert_redirected_to root_url
  end
end
