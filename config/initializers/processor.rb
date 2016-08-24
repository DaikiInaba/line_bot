require 'line/bot/api/version'
require 'line/bot/utils'
require 'net/http'
require 'uri'

module Line
  module Bot
    class Processor
      attr_accessor :client, :data, :from_mid

      def initialize(client, data)
        @client = client
        @data = data
        @from_mid = data.from_mid
      end

      def process
        case data
        when Line::Bot::Receive::Operation
          case data.content
          when Line::Bot::Operation::AddedAsFriend
            client.send_text(
              to_mid: from_mid,
              text: initial_processor,
            )
          end
        when Line::Bot::Receive::Message
          case data.content
          when Line::Bot::Message::Text
            client.send_text(
              to_mid: to_mid,
              text: data.content[:text],
            )
          end
        end
      end

      # private
      def initial_processor
        user = User.where(mid: from_mid).first_or_initialize
        user.save!

        message = "あなたをグループの一員として認めます！"
        message
      end

      def text_processor
        message = ""
      end

      def to_mid
        mids = User.all.map{|user| user.mid}
        mids.delete(from_mid)

        mids
      end
    end
  end
end
