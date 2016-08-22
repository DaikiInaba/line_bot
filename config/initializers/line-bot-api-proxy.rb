require 'rest-client'

module Line
  module Bot
    class HTTPClient
      def post
        Rails.logger.debug("aaaaaaaaaaaaaaaaaaaaaaa")
        RestClient.proxy = ENV["FIXIE_URL"]
        RestClient.post(url, payload, header)
      end

      def daiki
      end
    end
  end
end
