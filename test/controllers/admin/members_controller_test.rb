require "test_helper"

class Admin::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_members_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_members_update_url
    assert_response :success
  end
end
