require 'test_helper'

class Admin::CpdAdvertisementsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => CpdAdvertisement.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    CpdAdvertisement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CpdAdvertisement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_cpd_advertisement_url(assigns(:cpd_advertisement))
  end

  def test_edit
    get :edit, :id => CpdAdvertisement.first
    assert_template 'edit'
  end

  def test_update_invalid
    CpdAdvertisement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CpdAdvertisement.first
    assert_template 'edit'
  end

  def test_update_valid
    CpdAdvertisement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CpdAdvertisement.first
    assert_redirected_to admin_cpd_advertisement_url(assigns(:cpd_advertisement))
  end

  def test_destroy
    cpd_advertisement = CpdAdvertisement.first
    delete :destroy, :id => cpd_advertisement
    assert_redirected_to admin_cpd_advertisements_url
    assert !CpdAdvertisement.exists?(cpd_advertisement.id)
  end
end
