require "test_helper"

class Public::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_favorites_destroy_url
    assert_response :success
  end
end
