require 'test_helper'

class ProduitAutorisesControllerTest < ActionController::TestCase
  setup do
    @produit_autorise = produit_autorises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produit_autorises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produit_autorise" do
    assert_difference('ProduitAutorise.count') do
      post :create, produit_autorise: @produit_autorise.attributes
    end

    assert_redirected_to produit_autorise_path(assigns(:produit_autorise))
  end

  test "should show produit_autorise" do
    get :show, id: @produit_autorise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produit_autorise
    assert_response :success
  end

  test "should update produit_autorise" do
    put :update, id: @produit_autorise, produit_autorise: @produit_autorise.attributes
    assert_redirected_to produit_autorise_path(assigns(:produit_autorise))
  end

  test "should destroy produit_autorise" do
    assert_difference('ProduitAutorise.count', -1) do
      delete :destroy, id: @produit_autorise
    end

    assert_redirected_to produit_autorises_path
  end
end
