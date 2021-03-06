# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => User.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_user_url(assigns(:user))
  end

  def test_edit
    get :edit, :id => User.first
    assert_template 'edit'
  end

  def test_update_invalid
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => User.first
    assert_template 'edit'
  end

  def test_update_valid
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => User.first
    assert_redirected_to admin_user_url(assigns(:user))
  end

  def test_destroy
    user = User.first
    delete :destroy, :id => user
    assert_redirected_to admin_users_url
    assert !User.exists?(user.id)
  end
end
