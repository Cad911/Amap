require 'test_helper'

class CageotsControllerTest < ActionController::TestCase
  setup do
    @cageot = cageots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cageots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cageot" do
    assert_difference('Cageot.count') do
      post :create, cageot: @cageot.attributes
    end

    assert_redirected_to cageot_path(assigns(:cageot))
  end

  test "should show cageot" do
    get :show, id: @cageot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cageot
    assert_response :success
  end

  test "should update cageot" do
    put :update, id: @cageot, cageot: @cageot.attributes
    assert_redirected_to cageot_path(assigns(:cageot))
  end

  test "should destroy cageot" do
    assert_difference('Cageot.count', -1) do
      delete :destroy, id: @cageot
    end

    assert_redirected_to cageots_path
  end
end
