module Proof
  module RequireProof
    extend ActiveSupport::Concern

    def require_proof(options={})
      options[:authenticatable] ||= :User

      raw_token = request.headers['Authorization'].split(' ').last if request.headers['Authorization']
      token = Proof::Token.from_token(raw_token) if raw_token

      proof_class = options[:authenticatable].to_s.camelize.constantize

      @current_user ||= proof_class.find_by_id(token.data[:user_id]) if token

      render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
    end

    def current_user
      @current_user if @current_user
    end

    included do
    end
  end
end
