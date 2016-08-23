require 'line/bot/api/version'
require 'line/bot/utils'

module Line
  module Bot
    class Processor
      attr_accessor :client, :message, :to_mid

      def initialize(client, data)
        @client = client
        @data = data
        @to_mid = data.from_mid
      end

      def process
        case data
        when Line::Bot::Receive::Operation
          case data.content
          when Line::Bot::Operation::AddedAsFriend
            client.send_text(
              to_mid: to_mid,
              text: initial_processor,
            )
          end
        when Line::Bot::Receive::Message
          case data.content
          when Line::Bot::Message::Text
            client.send_text(
              to_mid: to_mid,
              text: text_processor,
            )
          end
        end
          client.send_text(
            to_mid: message.from_mid,
            text: text_processor,
          )

      end

      private
      def initial_processor
        user = User.where(mid: to_mid).first_or_initialize
        user.save!

        message = ""
        message += "ご登録ありがとうございます！\n"
        message += "こちらで気になるイベントのキーワードを登録してください\n"
        message += "https://line-lovers.herokuapp.com/keywords/new"

        message
      end

      def text_processor
        message = ""
        message = "テスト"
      end
    end
  end
end
