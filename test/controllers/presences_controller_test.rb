require "test_helper"

class PresencesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get presences_create_url
    assert_response :success
  end
end
