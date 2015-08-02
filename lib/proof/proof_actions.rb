module Proof
  module ProofActions
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def proof_actions(options={})
        options[:authenticatable] ||= :User
        options[:identifier] ||= :email
        options[:password] ||= :password
        options[:authenticate] ||= :authenticate
        cattr_accessor :proof_options
        self.proof_options = options
        include Proof::ProofActions::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def login
        proof_class = self.class.proof_options[:authenticatable].to_s.camelize.constantize
        identifier = self.class.proof_options[:identifier]
        user = proof_class.find_by(identifier => params[identifier])
        if user && user.send(self.class.proof_options[:authenticate], params[self.class.proof_options[:password]])
          render json: { auth_token: Proof::Token.from_data({ user_id: user.id }) }
        else
          render json: { error: "Invalid Credentials." }, status: :unauthorized
        end
      end
    end
  end
end
