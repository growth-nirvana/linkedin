module Linkedin
  class Client
    BASE_PATH = "rest".freeze
    BASE_URL = ENV.fetch("LINKEDIN_BASE_URL", "https://api.linkedin.com").freeze
    CONTENT_TYPE = "application/json".freeze
    LINKEDIN_VERSION = ENV.fetch("LINKEDIN_VERSION", "202206")
    DEBUG_OUTPUT = ENV.fetch("LINKEDIN_DEBUG_OUTPUT", "false") == "true"
    USER_AGENT = "Growth Nirvana Linkedin Client".freeze

    def call_api(method, path, opts = {})
      url = build_url(path)
      options = build_opts(opts)
      response = HTTParty.public_send(method, url, options)
      response.parsed_response
    end

    private

    def build_opts(opts)
      opts[:headers] ||= {}
      opts[:headers]["User-Agent"] = opts[:user_agent] unless opts[:headers]["User-Agent"]
      opts[:headers]["Content-Type"] = CONTENT_TYPE
      opts[:headers]["LinkedIn-Version"] = LINKEDIN_VERSION
      opts[:body] = opts[:body].to_json if opts[:body].is_a?(Hash)
      opts[:query] = opts[:query] if opts[:query].is_a?(Hash)
      opts[:debug_output] = DEBUG_OUTPUT ? Logger.new($stdout) : nil
      opts
    end

    def build_url(path)
      return path if path.include?("https://")
      "#{BASE_URL}/#{BASE_PATH}/#{path}"
    end
  end
end
