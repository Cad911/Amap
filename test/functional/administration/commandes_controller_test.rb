require 'test_helper'

class Administration::CommandesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
