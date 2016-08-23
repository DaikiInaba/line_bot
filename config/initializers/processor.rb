require 'line/bot/api/version'
require 'line/bot/utils'

module Line
  module Bot
    class Processor
      attr_accessor :client, :message

      def initialize(client, message)
        @client = client
        @message = message
      end

      def process
        case message.content
        when Line::Bot::Message::Text
          client.send_text(
            to_mid: message.from_mid,
            text: text_processor,
          )
        end
      end

      private
      def text_processor
        mid = message.from_mid
        user = User.where(mid: mid).first_or_initialize
        user.save!

        return new_keyword_path(mid: mid)
      end
    end
  end
end
