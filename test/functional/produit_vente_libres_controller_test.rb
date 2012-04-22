require 'test_helper'

class ProduitVenteLibresControllerTest < ActionController::TestCase
  setup do
    @produit_vente_libre = produit_vente_libres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produit_vente_libres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produit_vente_libre" do
    assert_difference('ProduitVenteLibre.count') do
      post :create, produit_vente_libre: @produit_vente_libre.attributes
    end

    assert_redirected_to produit_vente_libre_path(assigns(:produit_vente_libre))
  end

  test "should show produit_vente_libre" do
    get :show, id: @produit_vente_libre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produit_vente_libre
    assert_response :success
  end

  test "should update produit_vente_libre" do
    put :update, id: @produit_vente_libre, produit_vente_libre: @produit_vente_libre.attributes
    assert_redirected_to produit_vente_libre_path(assigns(:produit_vente_libre))
  end

  test "should destroy produit_vente_libre" do
    assert_difference('ProduitVenteLibre.count', -1) do
      delete :destroy, id: @produit_vente_libre
    end

    assert_redirected_to produit_vente_libres_path
  end
end
