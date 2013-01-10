require 'test_helper'

class PhoneControllerTest < ActionController::TestCase
  test "should get add_phone" do
    get :add_phone
    assert_response :success
  end

end
