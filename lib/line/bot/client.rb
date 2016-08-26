module Line
  module Bot
    class Client
      def get_image(id)
        endpoint_url = "https://trialbot-api.line.me/v1/bot/message/#{data.id}/content"
        response = nil

        uri = URI.parse(endpoint_url)
        Net::HTTP.start(uri.host, uri.port, use_ssl: true){|http|
          req = Net::HTTP::Get.new(uri.path)
          req["Content-type"] = "application/json; charset=UTF-8"
          req["X-Line-ChannelID"] = ENV["LINE_CHANNEL_ID"]
          req["X-Line-ChannelSecret"] = ENV["LINE_CHANNEL_SECRET"]
          req["X-Line-Trusted-User-With-ACL"] = ENV["LINE_CHANNEL_MID"]
          response = http.request(req)
        }

        response.body
      end
    end
  end
end
