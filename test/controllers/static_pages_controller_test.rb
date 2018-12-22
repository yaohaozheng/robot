require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "进入Home页面" do
    get :home
    assert_response :success
  end

  test "进入Help页面" do
    get :help
    assert_response :success
  end

end
