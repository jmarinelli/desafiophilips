require 'test_helper'

class CompanyControllerTest < ActionController::TestCase
  test "should get ranking" do
    get :ranking
    assert_response :success
  end

end
