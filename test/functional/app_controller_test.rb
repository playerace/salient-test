require 'test_helper'

class AppControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get contacts" do
    get :contacts
    assert_response :success
  end

end
