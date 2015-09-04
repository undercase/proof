module Proof
  module ProofActions
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def proof_actions(options={}, &block)
        options[:authenticatable] ||= :User
        options[:identifier] ||= :email
        options[:password] ||= :password
        options[:authenticate] ||= :authenticate
        options[:block] = nil
        if block_given?
          options[:block] = block
        end
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
          auth_token = Proof::Token.from_data({ user_id: user.id })
          json = { auth_token: auth_token }
          if !self.class.proof_options[:block].nil?
            json = self.class.proof_options[:block].call(user, auth_token)
          end
          render json: json
        else
          render json: { error: "Invalid Credentials." }, status: :unauthorized
        end
      end
    end
  end
end
