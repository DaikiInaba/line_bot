require 'line/bot/api/version'
require 'line/bot/utils'
require 'net/http'
require 'uri'

module Line
  module Bot
    class Processor
      attr_accessor :client, :data, :from_mid, :user

      def initialize(client, data)
        @client = client
        @data = data
        @from_mid = data.from_mid
        user = User.where(mid: data.from_mid).first_or_initialize
        user.save
        @user = user
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
            case data.content[:text]
            when /質問|聞きたい|について/
              unless user.questioner
                user.switch_questioner
                send_to_him("早速質問してみましょう！")
                send_to_them("#{user.name}さんが困ってるみたい！みんな助けてあげてね！")
              else
                send_to_them(text_processor)
              end
            when /ありがとう/
              user.switch_questioner if user.questioner
              send_to_him "解決したみたいね！おめでとう！"
              send_to_them "みんなのおかげで#{user.name}さんの悩みは解決したみたい！"
            else
              send_to_them(text_processor)
            end
          when Line::Bot::Message::Sticker
            user = User.where(mid: from_mid).first_or_initialize
            user.save!
          end
        end
      end

      private
      def initial_processor
      end

      def text_processor
        message = ""

        text = data.content[:text]
        if user.questioner
          case text
          when /[緊急]/
            message += "========================緊急========================"
            message += "#{user.name}さん:#{text}"
            message += "===================================================="
          else
            message += "#{user.name}さん:#{text}"
          end
        else
          message += text
        end

        message
      end

      def send_to_him(text)
        client.send_text(
          to_mid: from_mid,
          text: text,
        )
      end

      def send_to_them(text)
        client.send_text(
          to_mid: to_mids,
          text: text,
        )
      end

      def to_mids
        region = user.region
        mids = region.users.map{|member| member.mid}
        # mids.delete(from_mid)

        mids
      end
    end
  end
end
