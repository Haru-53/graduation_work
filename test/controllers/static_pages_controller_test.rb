require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get static_pages_top_url
    assert_response :success
  end

  test "should get explanation" do
    get static_pages_explanation_url
    assert_response :success
  end

  test "should get sample" do
    get static_pages_sample_url
    assert_response :success
  end
end
