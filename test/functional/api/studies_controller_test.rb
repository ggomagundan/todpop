require 'test_helper'

class Api::StudiesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
end
