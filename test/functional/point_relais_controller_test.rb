require 'test_helper'

class PointRelaisControllerTest < ActionController::TestCase
  setup do
    @point_relai = point_relais(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:point_relais)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create point_relai" do
    assert_difference('PointRelai.count') do
      post :create, point_relai: @point_relai.attributes
    end

    assert_redirected_to point_relai_path(assigns(:point_relai))
  end

  test "should show point_relai" do
    get :show, id: @point_relai
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @point_relai
    assert_response :success
  end

  test "should update point_relai" do
    put :update, id: @point_relai, point_relai: @point_relai.attributes
    assert_redirected_to point_relai_path(assigns(:point_relai))
  end

  test "should destroy point_relai" do
    assert_difference('PointRelai.count', -1) do
      delete :destroy, id: @point_relai
    end

    assert_redirected_to point_relais_path
  end
end
