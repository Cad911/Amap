require 'test_helper'

class AbonnementsControllerTest < ActionController::TestCase
  setup do
    @abonnement = abonnements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abonnements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abonnement" do
    assert_difference('Abonnement.count') do
      post :create, abonnement: @abonnement.attributes
    end

    assert_redirected_to abonnement_path(assigns(:abonnement))
  end

  test "should show abonnement" do
    get :show, id: @abonnement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abonnement
    assert_response :success
  end

  test "should update abonnement" do
    put :update, id: @abonnement, abonnement: @abonnement.attributes
    assert_redirected_to abonnement_path(assigns(:abonnement))
  end

  test "should destroy abonnement" do
    assert_difference('Abonnement.count', -1) do
      delete :destroy, id: @abonnement
    end

    assert_redirected_to abonnements_path
  end
end
