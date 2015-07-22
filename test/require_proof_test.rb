require 'test_helper'

class RequireProofTest < ActionController::TestCase
  @@authorized_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.aM3hZFSjILMLjRBOZSXmClIGJeoNgjqCDC37FyJ8RBg'

  def setup
    User.create(email: 'real@email.com', password: 'realpassword')

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

  def test_request_authorized_with_token
    @request.headers["Authorization"] = "Bearer #{@@authorized_token}"
    get :test
    assert_response :success
    assert_not_nil @controller.current_user
    assert_not_nil assigns(:current_user)
  end
end
