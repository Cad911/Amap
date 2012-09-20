require 'test_helper'

class Administration::BlogControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new_article" do
    get :new_article
    assert_response :success
  end

end
