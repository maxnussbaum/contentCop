require "json"
require "http"
require "uri"
require "nokogiri"
# require("httplog")
# HttpLog.configure do |config|
#   config.log_connect = true
#   config.log_request = true
#   config.log_headers = true
#   config.log_data = true
#   config.log_status = true
#   config.log_response = true
# end

def get_lyrics(artist, song)
  artist.gsub!(/ /, "_")
  song.gsub!(/ /, "_")
  url = URI.encode("https://lyrics.wikia.com/wiki/#{artist}:#{song}")
  response = HTTP.follow.get(url)
  doc = Nokogiri::HTML(response.body.to_s)
  doc.css("br").each{ |br| br.replace "\n" }
  value = doc.search("div.lyricbox")[0]
  return value.content
end