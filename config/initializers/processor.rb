require 'line/bot/api/version'
require 'line/bot/utils'

module Line
  module Bot
    class Processor
      attr_accessor :client, :data, :to_mid

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
            3.times do |i|
              client.send_text(
                to_mid: to_mid,
                text: initial_processor(i),
              )
            end
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
      end

      private
      def initial_processor(count)
        message = ""

        case count
        when 0
          user = User.where(mid: to_mid).first_or_initialize
          user.save!
          message += "ご登録ありがとうございます！"
          message += "\nイベントを逃さず遊びつくしましょう！"
        when 1
          message += "\n今開催中のおすすめイベントはこちら！"
        when 2
          Event.all.each do |event|
            message += "\n---------------------------------------"
            message += "\n#{event.name}"
            message += "\n#{event.event_url}"
          end
        end

        message
      end

      def text_processor
        message = ""
        text = data.content[:text]

        if /(?<month>\d{1,2})月(?<date>\d){1,2}日/ =~ text
          year = Date.today.to_s
          date = year + month + date
          events = Event.where('started_at <= ?', date).where('expired_at >= ?', date)
          return "#{month}月#{date}日に開催しているイベントはないみたいです..." if event.length == 0

          message += "#{month}月#{date}日に開催しているイベントは"
          events.each do |event|
            message += "\n---------------------------------------"
            message += "\n#{event.name}"
            message += "\n#{event.event_url}"
          end
          messgage += "です"
        end
        message
      end
    end
  end
end
