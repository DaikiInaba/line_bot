require 'rest-client'

module Line
  module Bot
    class HTTPClient

      # @return [Net::HTTP]
      def http(uri)
        http = Net::HTTP::Proxy(ENV["FIXIE_URL"])
        http = http.new(uri.host, uri.port)
        if uri.scheme == "https"
          http.use_ssl = true
        end

        http
      end

      def post(url, payload, header = {})
        uri = URI(url)
        http(uri).post(uri.request_uri, payload, header)
      end
    end
  end
end
