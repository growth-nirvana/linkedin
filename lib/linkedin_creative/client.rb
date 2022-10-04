module LinkedinCreative
  class Client
    BASE_PATH = "rest".freeze
    BASE_URL = ENV.fetch("LINKEDIN_CREATIVE_BASE_URL", "https://api.linkedin.com").freeze
    CONTENT_TYPE = "application/json".freeze
    LINKEDIN_VERSION = ENV.fetch("LINKEDIN_VERSION", "202206")
    DEBUG_OUTPUT = ENV.fetch("LINKEDIN_CREATIVE_DEBUG_OUTPUT", "false") == "true"
    USER_AGENT = "Growth Nirvana Linkedin Creative Client".freeze

    def call_api(method, path, opts = {})
      url = build_url(path)
      options = build_opts(opts)
      response = HTTParty.public_send(method, url, options)
      result = {http_code: response.code, body: response.parsed_response}
      result_klass = response.success? && response.parsed_response["code"].zero? ? Success : Error
      result_klass.new(result)
    end

    private

    def build_opts(opts)
      opts[:headers] ||= {}
      opts[:headers]["User-Agent"] = USER_AGENT
      opts[:headers]["Content-Type"] = CONTENT_TYPE
      opts[:headers]["LinkedIn-Version"] = LINKEDIN_VERSION
      opts[:body] = opts[:body].to_json if opts[:body].is_a?(Hash)
      opts[:debug_output] = DEBUG_OUTPUT ? Rails.logger : nil
      opts
    end

    def build_url(path)
      "#{BASE_URL}/#{BASE_PATH}/#{path}"
    end
  end
end