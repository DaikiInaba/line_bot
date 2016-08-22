require 'rest-client'

Line::Bot::HTTPClient.class_eval do
  def post(url, payload, header = {})
    RestClient.proxy = ENV["FIXIE_URL"]
    RestClient.post(url, payload, header)
  end
end
