require 'jwt'

module Proof
  class Token
    attr_reader :data, :expiration_date, :secret_key, :algorithm, :token

    def initialize(data, secret_key, algorithm, token)
      # Convert Raw Hash Keys into Ruby Symbols
      @data = Hash.new
      data.each do |key, value|
        @data[key.to_sym] = value
      end
      @expiration_date = @data[:exp]
      @secret_key = secret_key
      @algorithm = algorithm
      @token = token
    end


    def self.from_data(data, expires=true, secret_key=Rails.application.secrets.secret_key_base, algorithm='HS256', expiration_date=24.hours.from_now.to_i,)
      # Must Clone Data Hash to Avoid Side Effects
      data_immutable = data.clone
      if expires
        data_immutable = data.clone.merge({ exp: expiration_date })
      end
      token = JWT.encode(data_immutable, secret_key, algorithm)
      new(data_immutable, secret_key, algorithm, token)
    end

    def self.from_token(token, secret_key=Rails.application.secrets.secret_key_base, algorithm='HS256')
      decoded = JWT.decode(token, secret_key)
      data = decoded[0]
      if algorithm != algorithm_from_header(decoded[1])
        raise JWT::IncorrectAlgorithm.new("Payload algorithm is #{algorithm_from_header(decoded[1])} but #{algorithm} was used to Encrypt.")
      end
      new(data, secret_key, algorithm, token)
    end

    def self.algorithm_from_header(header)
      return header['alg']
    end
    private_class_method :algorithm_from_header

    def expired?
      return @expiration_date < Time.now.to_i
    end

    def to_s
      return token
    end
  end
end
