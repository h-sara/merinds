require "test_helper"

class Admin::PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_post_comments_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_post_comments_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_post_comments_update_url
    assert_response :success
  end
end
