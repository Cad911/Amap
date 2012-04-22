require 'test_helper'

class RelCageotProduitsControllerTest < ActionController::TestCase
  setup do
    @rel_cageot_produit = rel_cageot_produits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rel_cageot_produits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rel_cageot_produit" do
    assert_difference('RelCageotProduit.count') do
      post :create, rel_cageot_produit: @rel_cageot_produit.attributes
    end

    assert_redirected_to rel_cageot_produit_path(assigns(:rel_cageot_produit))
  end

  test "should show rel_cageot_produit" do
    get :show, id: @rel_cageot_produit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rel_cageot_produit
    assert_response :success
  end

  test "should update rel_cageot_produit" do
    put :update, id: @rel_cageot_produit, rel_cageot_produit: @rel_cageot_produit.attributes
    assert_redirected_to rel_cageot_produit_path(assigns(:rel_cageot_produit))
  end

  test "should destroy rel_cageot_produit" do
    assert_difference('RelCageotProduit.count', -1) do
      delete :destroy, id: @rel_cageot_produit
    end

    assert_redirected_to rel_cageot_produits_path
  end
end
