module PrStatus
  # Class to create the client wrapper around octokit
  class Auth
    # Credentials hash follows the octokit Client.new params:
    #  For username/password:
    #     login: username, password: password
    #
    #  For api_token (recommended) since username/password is not even sent
    #     auth_token: <github auth token 40 chars>
    def initialize(credentials)
      unless credentials.is_a?(Hash)
        fail ArgumentError, 'Need to pass in credentials hash'
      end
      @credentials = credentials

      validate_credentials if username? || password?
      if credentials[:access_token]
        validate_access_token(credentials[:access_token])
      end
 
    end

    def authenticate
      PrStatus::Client.new(@credentials)
    end

    private

    def validate_access_token(token)
      fail ArgumentError, 'Invalid Auth Token' unless token.length == 40
    end

    def validate_credentials
      fail ArgumentError, 'Password missing' if !password?
      fail ArgumentError, 'Username (:login) missing' if !username?
    end

    def username?
      @credentials[:login] && !@credentials[:login].empty?
    end

    def password?
      @credentials[:password] && !@credentials[:password].empty?
    end

    def credentials
      if @credentials[:auth_token]
        { auth_token: @credentials[:auth_token] }
      else
        { login: @credentials[:login], password: @credentials[:password] }
      end
    end
  end
end
