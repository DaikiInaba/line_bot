require 'rest-client'

module Line
  module Bot
    class HTTPClient

      # @return [Net::HTTP]
      def http(uri)
        http = Net::HTTP::Proxy(ENV["FIXIE_URL"])
        http = http.new(uri.host, uri.port)
        http.set_debug_output(Rails.logger)
        if uri.scheme == "https"
          http.use_ssl = true
        end

        http
      end
    end
  end
end
