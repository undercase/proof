require 'json'
require 'test_helper'

class BlockActionsTest < ActionController::TestCase
  def setup
    User.create(email: 'real@email.com', password: 'realpassword')

    @controller = BlockController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    Rails.application.routes.draw do
      post 'login', to: 'block#login'
    end
  end

  def test_proof_actions_block_works
    post :login, { 'email' => 'real@email.com', 'password' => 'realpassword' }
    response = JSON.parse(@response.body)

    assert_response :success

    assert_not_nil response['user_id']
    assert_not_nil response['email']
    assert_not_nil response['auth_token']
  end
end
