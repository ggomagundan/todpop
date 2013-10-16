require 'test_helper'

class Admin::CpdmAdvertisementsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => CpdmAdvertisement.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    CpdmAdvertisement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CpdmAdvertisement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_cpdm_advertisement_url(assigns(:cpdm_advertisement))
  end

  def test_edit
    get :edit, :id => CpdmAdvertisement.first
    assert_template 'edit'
  end

  def test_update_invalid
    CpdmAdvertisement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CpdmAdvertisement.first
    assert_template 'edit'
  end

  def test_update_valid
    CpdmAdvertisement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CpdmAdvertisement.first
    assert_redirected_to admin_cpdm_advertisement_url(assigns(:cpdm_advertisement))
  end

  def test_destroy
    cpdm_advertisement = CpdmAdvertisement.first
    delete :destroy, :id => cpdm_advertisement
    assert_redirected_to admin_cpdm_advertisements_url
    assert !CpdmAdvertisement.exists?(cpdm_advertisement.id)
  end
end
