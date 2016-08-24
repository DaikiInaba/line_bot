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
            user = User.find_by(mid: from_mid)
            res_flg = false
            to_mid, text = ""
            case data.content[:text]
            when /質問/
              user.update(question: true)
              user.save
              text = "早速質問しましょう！"
              to_mid = from_mid
            when /ありがとう/
              user.update(question: false)
              user.save
            else
              text = text_processor(user: user)
              to_mid = to_mids
            end
            if res_flg
              client.send_text(
                to_mid: to_mid,
                text: text,
              )
            end
          when Line::Bot::Message::Sticker
            user = User.where(mid: from_mid).first_or_initialize
            user.save!
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

      def text_processor(opts = {})
        message = ""

        text = data.content[:text]
        message = opts[:user].question ? "【質問者】:#{text}" : text

        message
      end

      def to_mids
        user = User.find_by(mid: from_mid)
        region = user.region
        mids = region.users.map{|member| member.mid}
        mids.delete(from_mid)

        mids
      end
    end
  end
end
