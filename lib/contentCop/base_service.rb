require("http")
require("json")
require("dotenv/load")
require("httplog")
HttpLog.configure do |config|
  config.log_connect = true
  config.log_request = true
  config.log_headers = true
  config.log_data = true
  config.log_status = true
  config.log_response = true
end

class BaseService
  attr_accessor :client_id, :client_secret
  attr_reader :conn, :url
  def initialize(client_id: nil, client_secret: nil)
    @url = "https://api.spotify.com"
    @client_id = ENV["CLIENT_ID"]
    @client_secret = ENV["CLIENT_SECRET"]
    conn = HTTP::Client.new()
    temp_conn = conn.basic_auth(user: @client_id, pass: @client_secret)
    response = temp_conn.request(
      "POST",
      "https://accounts.spotify.com/api/token",
      form: { grant_type: "client_credentials" }
    )
    response_hash = JSON.parse(response.body.to_s)
    puts response_hash.keys
    @conn = conn
    @conn.default_options.headers.add("Authorization", "Bearer #{response_hash["access_token"]}")
  end

  def request
    response = @conn.request(
      "POST",
      @url,
      form: { grant_type: "client_credentials" }
    )
    puts response.body
  end

  def get_user_profile(username)
    response = @conn.request(
      "GET",
      HTTP::URI.parse(@url + "/v1/users" + "/#{username}")
    )
    body = JSON.parse(response.body.to_s)
    puts body
  end
end
