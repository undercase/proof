class BlockController < ApplicationController
  proof_actions authenticatable: :User do |user, token|
    {
      user_id: user.id,
      email: user.email,
      auth_token: token
    }
  end
  before_action :require_proof, except: :login
  
  def test
    render json: { status: 'authorized' }
  end
end
