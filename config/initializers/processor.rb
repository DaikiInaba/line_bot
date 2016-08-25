require 'line/bot/api/version'
require 'line/bot/utils'

module Line
  module Bot
    class Processor
      attr_accessor :client, :data, :text, :from_mid, :user

      def initialize(client, data)
        @client = client
        @data = data
        @text = data.content[:text]
        @from_mid = data.from_mid
        user = User.where(mid: data.from_mid).first_or_initialize
        user.save!
        @user = user
      end

      def process
        case data
        when Line::Bot::Receive::Operation
          case data.content
          when Line::Bot::Operation::AddedAsFriend
            initial_processor
          end
        when Line::Bot::Receive::Message
          case data.content
          when Line::Bot::Message::Text
            if user.stage > 5
              case text
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
            else
              initial_processor
            end
          when Line::Bot::Message::Sticker
            client.send_sticker(
              to_mid: to_mids,
              stkpkgid: data.content[:stkpkgid],
              stkid: data.content[:stkid],
              stkver: data.content[:stkver],
            )
          end
        end
      end

      private
      def initial_processor
        if text == "更新"
          user.stage = 0
          user.save
        end

        message = ""

        if user.stage < 5
          # management
          case user.stage
          when 1
            region = Region.find_by(name: text)
            unless region
              send_to_him("知らない場所だわ...ごめんなさい...")
              send_to_him("もう一度聞いてもいいかしら？")
            else
              user.region = region
              user.increment!(:stage)
              send_to_him("ふ～ん...#{region.name}によく行くのね")
            end
          when 2
            length = text.match(/\d{1,2}/).to_s.to_i
            case length
            when 12 .. Float::INFINITY
              send_to_him("あら、結構長いじゃない")
            when 3 .. 12
              send_to_him("彼氏歴もそこそこね")
            when 0 .. 3
              send_to_him("新米彼氏さんなのね")
            else
              send_to_him("恥ずかしがらずにちゃんと答えなさい！")
            end

            user.increment!(:stage) if length
          when 3
            case text.length
            when 15 .. Float::INFINITY
              send_to_him("あら♪なかなかいい出会いじゃない♪")
              user.increment!(:stage)
            when 10 .. 15
              send_to_him("もう少し詳しく教えてちょうだい？")
            when 0 .. 10
              send_to_him("短すぎるわ！")
            end
          when 4
            if text.length < 20
              send_to_him("短いわ！もっといろいろあるでしょう？")
              send_to_him("恥ずかしからずにちゃんと教えてちょうだい！")
            else
              send_to_him("なかなか素敵な彼女みたいね♪")
              user.increment!(:stage)
            end
          when 5
            user.increment!(:stage)
          end

          # management
          case user.stage
          when 0
            messages = BotMessage.find_by(stage: user.stage)
            messages.text.split("<section>").each do |message|
              send_to_him(message)
            end
            user.increment!(:stage)
          else
            message = BotMessage.find_by(stage: user.stage)
            send_to_him(message.text)
          end
        else
        end
      end

      def text_processor
        message = ""

        if user.questioner
          case text
          when /[緊急]/
            text.slice!("[緊急]")
            message += "========================緊急========================"
            message += "\n#{user.name}さん:"
            message += "\n#{text}"
            message += "\n===================================================="
          else
            message += "#{user.name}さん:"
            message += "\n#{text}"
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
        mids.delete(from_mid)

        mids
      end
    end
  end
end
