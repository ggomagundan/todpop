require 'test_helper'

class EtcControllerTest < ActionController::TestCase
  test "should get refund_info" do
    get :refund_info
    assert_response :success
  end

end
