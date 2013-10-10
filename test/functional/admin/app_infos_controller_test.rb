# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::AppInfosControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => AppInfo.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    AppInfo.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    AppInfo.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_app_info_url(assigns(:app_info))
  end

  def test_edit
    get :edit, :id => AppInfo.first
    assert_template 'edit'
  end

  def test_update_invalid
    AppInfo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AppInfo.first
    assert_template 'edit'
  end

  def test_update_valid
    AppInfo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AppInfo.first
    assert_redirected_to admin_app_info_url(assigns(:app_info))
  end

  def test_destroy
    app_info = AppInfo.first
    delete :destroy, :id => app_info
    assert_redirected_to admin_app_infos_url
    assert !AppInfo.exists?(app_info.id)
  end
end
