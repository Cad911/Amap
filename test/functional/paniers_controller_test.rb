require 'test_helper'

class PaniersControllerTest < ActionController::TestCase
  setup do
    @panier = paniers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paniers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panier" do
    assert_difference('Panier.count') do
      post :create, panier: @panier.attributes
    end

    assert_redirected_to panier_path(assigns(:panier))
  end

  test "should show panier" do
    get :show, id: @panier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @panier
    assert_response :success
  end

  test "should update panier" do
    put :update, id: @panier, panier: @panier.attributes
    assert_redirected_to panier_path(assigns(:panier))
  end

  test "should destroy panier" do
    assert_difference('Panier.count', -1) do
      delete :destroy, id: @panier
    end

    assert_redirected_to paniers_path
  end
end
