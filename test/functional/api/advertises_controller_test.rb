require 'test_helper'

class Api::AdvertisesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
end
