class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  require 'line/bot'

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_mid = ENV["LINE_CHANNEL_MID"]
    }

    signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
    unless client.validate_signature(request.body.read, signature)
      error 400 do 'Bad Request' end
    end

    receive_request = Line::Bot::Receive::Request.new(request.env)
    receive_request.data.each do |message|
      case message.content
      when Line::Bot::Message::Text
        Rails.logger.debug message.from_mid
        Rails.logger.debug message.content[:text]
        logger.debug(client.send_text(
          to_mid: message.from_mid,
          text: message.content[:text],
        ))
      end
    end
    render nothing: true
  end
end
