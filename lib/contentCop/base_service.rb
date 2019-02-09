require("http")
require("json")
require("dotenv/load")

class BaseService
  attr_accessor :client_id, :client_secret
  attr_reader :conn, :url
  def initialize(client_id: nil, client_secret: nil)
    @url = "https://accounts.spotify.com/api/token"
    @client_id = ENV["CLIENT_ID"]
    @client_secret = ENV["CLIENT_SECRET"]
    conn = HTTP::Client.new()
    @conn = conn.basic_auth(user: @client_id, pass: @client_secret)
  end

  def request
    response = @conn.request(
      HTTP::URI.parse(@url),
      form: { grant_type: "client_credentials" }
    )
    puts response.body
  end
end
