require 'rest-client'

module Line
  module Bot
    class HTTPClient
      def post
        Rails.logger.debug("aaaaaaaaaaaaaaaaaaaaaaa")
        RestClient.proxy = ENV["FIXIE_URL"]
        RestClient.post(url, payload, header)
      end
    end
  end
end
