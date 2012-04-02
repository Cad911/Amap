require 'test_helper'

class ProduitPaniersControllerTest < ActionController::TestCase
  setup do
    @produit_panier = produit_paniers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produit_paniers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produit_panier" do
    assert_difference('ProduitPanier.count') do
      post :create, produit_panier: @produit_panier.attributes
    end

    assert_redirected_to produit_panier_path(assigns(:produit_panier))
  end

  test "should show produit_panier" do
    get :show, id: @produit_panier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produit_panier
    assert_response :success
  end

  test "should update produit_panier" do
    put :update, id: @produit_panier, produit_panier: @produit_panier.attributes
    assert_redirected_to produit_panier_path(assigns(:produit_panier))
  end

  test "should destroy produit_panier" do
    assert_difference('ProduitPanier.count', -1) do
      delete :destroy, id: @produit_panier
    end

    assert_redirected_to produit_paniers_path
  end
end
