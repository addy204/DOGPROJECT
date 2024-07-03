require "test_helper"

class SubBreedsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sub_breeds_show_url
    assert_response :success
  end
end
