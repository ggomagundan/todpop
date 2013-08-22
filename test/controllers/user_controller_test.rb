require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get email:string" do
    get :email:string
    assert_response :success
  end

  test "should get facebook:string" do
    get :facebook:string
    assert_response :success
  end

  test "should get password:password" do
    get :password:password
    assert_response :success
  end

  test "should get nickname:string" do
    get :nickname:string
    assert_response :success
  end

  test "should get recommend:string" do
    get :recommend:string
    assert_response :success
  end

  test "should get sex:int" do
    get :sex:int
    assert_response :success
  end

  test "should get birth:date" do
    get :birth:date
    assert_response :success
  end

  test "should get address:string" do
    get :address:string
    assert_response :success
  end

  test "should get mobile:string" do
    get :mobile:string
    assert_response :success
  end

  test "should get date:datetime" do
    get :date:datetime
    assert_response :success
  end

  test "should get late_connection:datetime" do
    get :late_connection:datetime
    assert_response :success
  end

  test "should get level_test:int" do
    get :level_test:int
    assert_response :success
  end

end
