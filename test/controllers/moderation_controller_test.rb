require 'test_helper'

class ModerationControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get moderation_update_url
    assert_response :success
  end

end
