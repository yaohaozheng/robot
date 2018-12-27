require 'test_helper'

class PrefriendshipsControllerTest < ActionController::TestCase
  setup do
    @prefriendship = prefriendships(:one)
  end

  test "should create prefriendship" do
    assert_difference('Prefriendship.count') do
      post :create, prefriendship: {  }
    end

    assert_redirected_to prefriendship_path(assigns(:prefriendship))
  end

  test "should destroy prefriendship" do
    assert_difference('Prefriendship.count', -1) do
      delete :destroy, id: @prefriendship
    end

    assert_redirected_to prefriendships_path
  end
end
