class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def callback
    logger.debug(ENV["LINE_CHANNEL_ID"])
    logger.debug(ENV["LINE_CHANNEL_SECRET"])
    logger.debug(ENV["LINE_CHANNEL_MID"])

    client = Line::Bot::Client.new { |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_id = ENV["LINE_CHANNEL_SECRET"]
      config.channel_id = ENV["LINE_CHANNEL_MID"]
    }

    signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
    unless client.validate_signature(request.body.read, signature)
      error 400 do 'Bad Request' end
    end

    receive_request = Line::Bot::Receive::Request.new(request.env)
    receive_request.data.each do |message|
      case message.content
      when Line::Bot::Message::Text
        client.send_text(
          to_mid: message.from_mid,
          text: message.content[:text],
        )
      end
    end
  end
end
