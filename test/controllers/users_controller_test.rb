require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    # 管路员用户
    @user = users(:david)
    # 其他用户
    @other_user = users(:steve)
  end
  test "未登陆时，访问/users页面，重定向到登陆界面" do
    get :index
    assert_response :redirect
    assert_redirected_to sessions_login_url
  end
  test "进入new页面" do
    get :new
    assert_response :success
  end
  test "未登陆时，访问edit页面，重定向到登陆界面" do
    get :edit, id: @user.id
    assert_not flash.empty?
    assert_response :redirect
    assert_redirected_to sessions_login_url
  end
  test "未登陆时，访问update页面，重定向到登陆界面" do
    patch :update, id: @user.id, params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to sessions_login_url
  end


  test "已登陆用户，访问另一个用户edit页面，重定向到root界面" do
    log_in_as(@other_user)
    get :edit, id: @user.id
    assert_not flash.empty?
    assert_response :redirect
    assert_redirected_to root_url
  end
  test "已登陆用户，访问另一个用户update页面，重定向到root界面" do
    log_in_as(@other_user)
    patch :update, id:@user.id, params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "未登陆时，访问destroy页面，重定向到登陆界面" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user.id
    end
    assert_redirected_to sessions_login_url
  end

  test "已登陆用户不是管理员时，访问destroy页面，重定向到root界面" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user.id
    end
    assert_redirected_to root_url
  end
end
