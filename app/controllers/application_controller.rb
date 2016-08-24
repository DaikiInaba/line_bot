require 'line/bot'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

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
    receive_request.data.each do |data|
      Rails.logger.debug("==========================================")
      Rails.logger.debug(data.content[:originalContentUrl])
      Rails.logger.debug(data.content[:image_url])
      Rails.logger.debug("==========================================")
      processor = Line::Bot::Processor.new(client, data)
      processor.process
    end
    render nothing: true
  end
end
