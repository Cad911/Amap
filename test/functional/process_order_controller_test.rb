require 'test_helper'

class ProcessOrderControllerTest < ActionController::TestCase
  test "should get resume" do
    get :resume
    assert_response :success
  end

  test "should get confirmation" do
    get :confirmation
    assert_response :success
  end

  test "should get paiement" do
    get :paiement
    assert_response :success
  end

end
