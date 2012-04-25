require 'test_helper'

class RelCommandeProduitsControllerTest < ActionController::TestCase
  setup do
    @rel_commande_produit = rel_commande_produits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rel_commande_produits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rel_commande_produit" do
    assert_difference('RelCommandeProduit.count') do
      post :create, rel_commande_produit: @rel_commande_produit.attributes
    end

    assert_redirected_to rel_commande_produit_path(assigns(:rel_commande_produit))
  end

  test "should show rel_commande_produit" do
    get :show, id: @rel_commande_produit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rel_commande_produit
    assert_response :success
  end

  test "should update rel_commande_produit" do
    put :update, id: @rel_commande_produit, rel_commande_produit: @rel_commande_produit.attributes
    assert_redirected_to rel_commande_produit_path(assigns(:rel_commande_produit))
  end

  test "should destroy rel_commande_produit" do
    assert_difference('RelCommandeProduit.count', -1) do
      delete :destroy, id: @rel_commande_produit
    end

    assert_redirected_to rel_commande_produits_path
  end
end
