require 'proof/token.rb'
require 'proof/proof_actions.rb'

module Proof
  ActionController::Base.send :include, Proof::ProofActions
end
