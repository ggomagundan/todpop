require 'test_helper'

class Admin::CacaoMentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => CacaoMent.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    CacaoMent.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CacaoMent.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_cacao_ment_url(assigns(:cacao_ment))
  end

  def test_edit
    get :edit, :id => CacaoMent.first
    assert_template 'edit'
  end

  def test_update_invalid
    CacaoMent.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CacaoMent.first
    assert_template 'edit'
  end

  def test_update_valid
    CacaoMent.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CacaoMent.first
    assert_redirected_to admin_cacao_ment_url(assigns(:cacao_ment))
  end

  def test_destroy
    cacao_ment = CacaoMent.first
    delete :destroy, :id => cacao_ment
    assert_redirected_to admin_cacao_ments_url
    assert !CacaoMent.exists?(cacao_ment.id)
  end
end
