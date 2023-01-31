require "test_helper"

class Public::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_relationships_destroy_url
    assert_response :success
  end

  test "should get followings" do
    get public_relationships_followings_url
    assert_response :success
  end

  test "should get followers" do
    get public_relationships_followers_url
    assert_response :success
  end
end
