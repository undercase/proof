class AuthenticationController < ApplicationController
  proof_actions authenticate: :authenticate
  before_action :require_proof, except: :login

  def test
    render json: { status: 'authorized' }
  end
end
