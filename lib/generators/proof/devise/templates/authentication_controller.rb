class AuthenticationController < ApplicationController
  proof_actions authenticatable: :authenticatable_class_name
end
