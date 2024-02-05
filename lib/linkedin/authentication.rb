module Linkedin
  class Authentication
    def initialize(client = Client.new)
      @client = client
    end

    # Fetch the long term access token for the user.
    # @see https://learn.microsoft.com/en-us/linkedin/shared/authentication/authorization-code-flow
    #
    # @param code [String] Authorization code provided once the callback is completed.
    # @param secret [String] The private key of the developer's app
    def access_token(code:, client_id:, client_secret:, redirect_uri:)
      @client.call_api(
        :post,
        "https://www.linkedin.com/oauth/v2/accessToken",
        {
          query: {
            grant_type: "authorization_code",
            code: code,
            client_id: client_id,
            client_secret: client_secret,
            redirect_uri: redirect_uri
          },
          headers: {
            "User-Agent" => "x-www-form-urlencoded"
          }
        }
      )
    end

    def refresh_token(refresh_token:, client_id:, client_secret:)
      @client.call_api(
        :post,
        "https://www.linkedin.com/oauth/v2/accessToken",
        {
          query: {
            grant_type: "refresh_token",
            refresh_token: refresh_token,
            client_id: client_id,
            client_secret: client_secret
          },
          headers: {
            "User-Agent" => "x-www-form-urlencoded"
          }
        }
      )
    end
  end
end
