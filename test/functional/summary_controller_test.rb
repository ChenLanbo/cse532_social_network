require 'test_helper'

class SummaryControllerTest < ActionController::TestCase
  test "should get transaction" do
    get :transaction
    assert_response :success
  end

  test "should get stat" do
    get :stat
    assert_response :success
  end

end
