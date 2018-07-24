require 'test_helper'

class WishlistitemsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get wishlistitems_add_url
    assert_response :success
  end

  test "should get remove" do
    get wishlistitems_remove_url
    assert_response :success
  end

  test "should get index" do
    get wishlistitems_index_url
    assert_response :success
  end

end
