require 'test_helper'

class RequireProofTest < ActionController::TestCase
  def setup
    @controller = AuthenticationController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    Rails.application.routes.draw do
      get 'test' => 'authentication#test'
    end
  end

  def test_request_unauthorized_without_token
    get :test
    assert_response :unauthorized
  end
end
