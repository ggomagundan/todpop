require 'test_helper'

class Admin::CpxAdvertisementsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => CpxAdvertisement.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    CpxAdvertisement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CpxAdvertisement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_cpx_advertisement_url(assigns(:cpx_advertisement))
  end

  def test_edit
    get :edit, :id => CpxAdvertisement.first
    assert_template 'edit'
  end

  def test_update_invalid
    CpxAdvertisement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CpxAdvertisement.first
    assert_template 'edit'
  end

  def test_update_valid
    CpxAdvertisement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CpxAdvertisement.first
    assert_redirected_to admin_cpx_advertisement_url(assigns(:cpx_advertisement))
  end

  def test_destroy
    cpx_advertisement = CpxAdvertisement.first
    delete :destroy, :id => cpx_advertisement
    assert_redirected_to admin_cpx_advertisements_url
    assert !CpxAdvertisement.exists?(cpx_advertisement.id)
  end
end
