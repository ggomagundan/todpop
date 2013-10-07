require 'test_helper'

class Api::NoticesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
end
