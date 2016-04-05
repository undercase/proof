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
      @expiration_date = @data[:exp] if !@data[:exp].nil?
      @secret_key = secret_key
      @algorithm = algorithm
      @token = token
    end

    def self.from_data(data, expire_token=true, secret_key=Rails.application.secrets.secret_key_base, algorithm='HS256', expiration_date=24.hours.from_now.to_i)
      # Must Clone Data Hash to Avoid Side Effects
      if expire_token
        data_immutable = data.clone.merge({ exp: expiration_date })
      else
        data_immutable = data.clone
      end
      token = JWT.encode(data_immutable, secret_key, algorithm)
      new(data_immutable, secret_key, algorithm, token)
    end

    def self.from_token(token, secret_key=Rails.application.secrets.secret_key_base, algorithm='HS256')
      decoded = JWT.decode(token, secret_key, true, { algorithm: algorithm })
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
      return false unless @expiration_date
      return @expiration_date < Time.now.to_i
    end

    def to_s
      return token
    end
  end
end
