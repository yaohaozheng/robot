require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "进入登录页面" do
    get :new
    assert_response :success
  end
end
