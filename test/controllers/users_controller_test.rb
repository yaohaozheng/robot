require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "没登陆时访问/users页面，应该提醒登陆" do
    get :index
    assert_redirected_to sessions_login_url
  end
  test "进入注册页面" do
    get :new
    assert_response :success
  end
  test "没登陆时访问编辑用户，返回登陆界面" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "没登陆时应该重定向到root" do
    get users_path
    assert_redirected_to root_url
  end
end
