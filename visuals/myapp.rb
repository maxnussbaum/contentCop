require "sinatra"
require "sinatra/reloader"
require_relative("./../lib/contentCop")
require "dotenv/load"
require "http"
require("httplog")
HttpLog.configure do |config|
  config.log_connect = true
  config.log_request = true
  config.log_headers = true
  config.log_data = true
  config.log_status = true
  config.log_response = true
end

$a = ContentCop::User.new
$a.username = ENV["USERNAME"]

get "/" do
  response = HTTP.follow.get("https://accounts.spotify.com/authorize?client_id=#{ENV["CLIENT_ID"]}&response_type=code&redirect_uri=localhost:4567/callback&scope=playlist-modify-public&show_dialog=true")
  puts response.to_s
  @body = response.to_s
  erb :landing_page
  #$a.client_init
end

get "/playlists" do
  $a.get_user_playlists
  @playlists = $a.playlists.values
  erb :playlist_list
end

get "/playlist/:id" do
  unencoded = CGI::unescape(params[:id])
  playlist = $a.playlists[unencoded]
  playlist.get_tracks($a.conn)
  $a.playlists[unencoded] = playlist
  @playlist = playlist
  erb :playlist_view
end

get "/callback" do
  "CALLBACK"
end