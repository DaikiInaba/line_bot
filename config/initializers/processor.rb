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
            if user.stage > 3
              case text
              when /\p{Han}+(で|について|を)質問/
                unless user.questioner
                  region_name = text.match(/\p{Han}+(?=(で|について|を)質問)/)
                  if region_name
                    region_name = region_name.to_s
                    region = Region.find_by(name: region_name)
                    if region
                      user.switch_region(region: region)
                      user.switch_questioner

                      send_to_him("あなたを#{region_name}に招待したわ！さっそくみんなに質問してみましょう！")
                      send_to_them("#{user.name}さんが困ってるみたい！みんな助けてあげてね！")
                    else
                      send_to_him("そこについて詳しい人はまだいないみたい...力になれずごめんなさい...")
                    end
                  else
                    send_to_him("どこのことを質問したいのかしら？\n「渋谷で質問」みたいに教えてくれると嬉しいわ。")
                  end
                else
                  send_to_them(text_processor)
                end
              when /ありがとう/
                if user.questioner
                  send_to_them(text_processor)
                  user.switch_questioner if user.questioner

                  send_to_them "みんなのおかげで#{user.name}さんの悩みは解決したみたい！"
                  user.switch_region

                  send_to_him "無事解決したみたいね！おかえりなさい！"
                  send_to_him "今度はあなたは#{user.region.name}について教えてあげる番よ！"
                else
                  send_to_them(text_processor)
                end
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
        msg_flg = false
          # management
        case user.stage
        when 0
          messages = BotMessage.find_by(stage: user.stage)
          messages.text.split("<section>").each do |message|
            send_to_him(message)
          end
          msg_flg = true
          user.increment!(:stage)
        when 1
          region = Region.find_by(name: text)
          unless region
            send_to_him("知らない場所だわ...ごめんなさい...")
            send_to_him("もう一度聞いてもいいかしら？")
          else
            user.region = region
            msg_flg = true
            user.increment!(:stage)
            send_to_him("ふ～ん...#{region.name}によく行くのね")
          end
        when 2
          if text =~ /年/
            length = 100
          else
            length = text.match(/\d{1,2}/)
            length = length.to_s.to_i if length
          end

          case length
          when 12 .. Float::INFINITY
            send_to_him("結構長いのね。ぜひ後輩たちにいろいろ教えてあげてちょうだい！")
          when 3 .. 12
            send_to_him("彼氏歴もそこそこって感じかしら？")
          when 0 .. 3
            send_to_him("新米さんなのね。ここで先輩にいろいろ聞いてみるといいわよ。")
          else
            send_to_him("ごめんなさい。ちょっとわからないわ。もう一度教えてくれるかしら？")
          end

          if length
            msg_flg =  true
            user.increment!(:stage)
          end
        when 3
          case text.length
          when 15 .. Float::INFINITY
            send_to_him("あら！なかなかいい出会いじゃない！")
            msg_flg =  true
            user.increment!(:stage)
          when 10 .. 15
            send_to_him("もう少し詳しく教えてくれるかしら？")
          when 0 .. 10
            send_to_him("さすがに短すぎるわね...もっといろいろあるんじゃないかしら？")
          end
        end

        # management
        if user.stage == 4
          messages = BotMessage.find_by(stage: user.stage)
          messages.text.split("<section>").each do |message|
            send_to_him(message)
            sleep 5 if message =~ /\.+/
          end
        else
          message = BotMessage.find_by(stage: user.stage)
          send_to_him(message.text) if msg_flg
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
        region = user.tmp_region_id ? Region.find_by(user.tmp_region_id) : user.region
        mids = region.users.map{|member| member.mid}
        mids.delete(from_mid)

        mids
      end
    end
  end
end
