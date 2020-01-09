require 'test_helper'

class InstagramControllerTest < ActionDispatch::IntegrationTest
  test "should get connect" do
    get instagram_connect_url
    assert_response :success
  end

  test "should get authorize" do
    get instagram_authorize_url
    assert_response :success
  end

  test "should get media" do
    get instagram_media_url
    assert_response :success
  end

  test "should get feed" do
    get instagram_feed_url
    assert_response :success
  end

end
