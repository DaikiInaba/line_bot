module Line
  module Bot
    class MessageProcessor
      def process(client, message)
        case message.content
        when Line::Bot::Message::Text
          client.send_text{
            to_mid: message.from_mid,
            text: text_processor(message)
          }
        when Line::Bot::Message::Location
        end
      end
    end

    def text_processor(message)
      # 初回
      mid = message.from_mid
      user = User.where(mid: mid).first_or_initialize
      user.save

      return new_keyword_path(mid: mid)
    end
  end
end
