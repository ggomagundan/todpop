require 'test_helper'

class Api::ValidNicknamesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ValidNickname.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ValidNickname.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ValidNickname.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to api_valid_nickname_url(assigns(:valid_nickname))
  end

  def test_edit
    get :edit, :id => ValidNickname.first
    assert_template 'edit'
  end

  def test_update_invalid
    ValidNickname.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ValidNickname.first
    assert_template 'edit'
  end

  def test_update_valid
    ValidNickname.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ValidNickname.first
    assert_redirected_to api_valid_nickname_url(assigns(:valid_nickname))
  end

  def test_destroy
    valid_nickname = ValidNickname.first
    delete :destroy, :id => valid_nickname
    assert_redirected_to api_valid_nicknames_url
    assert !ValidNickname.exists?(valid_nickname.id)
  end
end
