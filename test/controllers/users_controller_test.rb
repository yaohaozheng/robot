require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "没登陆时应该重定向到root" do
    get users_path
    assert_redirected_to root_url
  end
end
