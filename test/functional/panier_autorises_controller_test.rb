require 'test_helper'

class PanierAutorisesControllerTest < ActionController::TestCase
  setup do
    @panier_autorise = panier_autorises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panier_autorises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panier_autorise" do
    assert_difference('PanierAutorise.count') do
      post :create, panier_autorise: @panier_autorise.attributes
    end

    assert_redirected_to panier_autorise_path(assigns(:panier_autorise))
  end

  test "should show panier_autorise" do
    get :show, id: @panier_autorise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @panier_autorise
    assert_response :success
  end

  test "should update panier_autorise" do
    put :update, id: @panier_autorise, panier_autorise: @panier_autorise.attributes
    assert_redirected_to panier_autorise_path(assigns(:panier_autorise))
  end

  test "should destroy panier_autorise" do
    assert_difference('PanierAutorise.count', -1) do
      delete :destroy, id: @panier_autorise
    end

    assert_redirected_to panier_autorises_path
  end
end
