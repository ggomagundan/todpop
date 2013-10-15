require 'test_helper'

class CpdAdvertisementsControllerTest < ActionController::TestCase
  setup do
    @cpd_advertisement = cpd_advertisements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cpd_advertisements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cpd_advertisement" do
    assert_difference('CpdAdvertisement.count') do
      post :create, cpd_advertisement: { back_image: @cpd_advertisement.back_image, count: @cpd_advertisement.count, coupon_id: @cpd_advertisement.coupon_id, end_time: @cpd_advertisement.end_time, front_image: @cpd_advertisement.front_image, kind: @cpd_advertisement.kind, remain: @cpd_advertisement.remain, start_time: @cpd_advertisement.start_time }
    end

    assert_redirected_to cpd_advertisement_path(assigns(:cpd_advertisement))
  end

  test "should show cpd_advertisement" do
    get :show, id: @cpd_advertisement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cpd_advertisement
    assert_response :success
  end

  test "should update cpd_advertisement" do
    patch :update, id: @cpd_advertisement, cpd_advertisement: { back_image: @cpd_advertisement.back_image, count: @cpd_advertisement.count, coupon_id: @cpd_advertisement.coupon_id, end_time: @cpd_advertisement.end_time, front_image: @cpd_advertisement.front_image, kind: @cpd_advertisement.kind, remain: @cpd_advertisement.remain, start_time: @cpd_advertisement.start_time }
    assert_redirected_to cpd_advertisement_path(assigns(:cpd_advertisement))
  end

  test "should destroy cpd_advertisement" do
    assert_difference('CpdAdvertisement.count', -1) do
      delete :destroy, id: @cpd_advertisement
    end

    assert_redirected_to cpd_advertisements_path
  end
end
