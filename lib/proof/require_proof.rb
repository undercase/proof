module Proof
  module RequireProof
    extend ActiveSupport::Concern

    def require_proof
      raw_token = request.headers['Authorization'].split(' ').last if request.headers['Authorization']
      token = Proof::Token.from_token(raw_token) if raw_token

      @current_user ||= User.find(token.data[:user_id]) if token

      render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
    end

    def current_user
      @current_user if @current_user
    end

    included do
    end
  end
end
