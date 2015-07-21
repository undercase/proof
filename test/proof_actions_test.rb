require 'json'
require 'test_helper'

class ProofActionsTest < ActionController::TestCase
  def setup
    User.create(email: 'real@email.com', password: 'realpassword')

    @controller = AuthenticationController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    
    Rails.application.routes.draw do
      post 'login' => 'authentication#login'
    end
  end

  def test_proof_actions_defines_login_method
    assert @controller.respond_to? :login
  end

  def test_proof_actions_invalid_user_returns_unauthorized
    post :login, { 'identifier' => 'fake@email.com', 'password' => 'password' }
    assert_response :unauthorized
  end

  def test_proof_actions_valid_user_returns_token
    post :login, { 'identifier' => 'real@email.com', 'password' => 'realpassword' }
    response = JSON.parse(@response.body)

    assert_response :success
    assert_not_nil response['auth_token']
  end
end
