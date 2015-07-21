require 'proof/token.rb'
require 'proof/proof_actions.rb'
require 'proof/require_proof.rb'

module Proof
  ActionController::Base.send :include, Proof::ProofActions
  ActionController::Base.send :include, Proof::RequireProof
end
