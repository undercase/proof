require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  # Utility variables
  @@data = {
    username: 'johnsmith',
    password: 'password'
  }

  # Utility methods
  def exp_removed(data)
    # Remove expiration date from hash
    d = data.clone
    d.delete(:exp)
    d
  end



  def test_create_token_from_data
    token = Proof::Token.from_data(@@data)
  end

  def test_create_token_from_encoded
    # Pre-encoded token generated from Token class defaults and @@data
    assert_raise JWT::ExpiredSignature do
      token = Proof::Token.from_token('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImpvaG5zbWl0aCIsInBhc3N3b3JkIjoicGFzc3dvcmQiLCJleHAiOjE0Mzc1Mjc3Mjh9.GXmzrexiyYaRGnKJ7Mv7HFvZTm4JwgJ8uCYQ3DN941M')
      assert_equal @@data, exp_removed(token.data)
      assert_equal true, token.expired?
      assert_equal 'HS256', token.algorithm
    end
  end
end
