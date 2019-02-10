require "http"
require "json"

class Playlist
  attr_accessor :id, :name, :owner, :uri, :tracks_href, :track_count, :tracks, :url_encoded_name
  def initialize(args)
    @id = args["id"]
    @name = args["name"]
    @url_encoded_name = CGI.escape(args["name"])
    @owner = args["owner"]
    @uri = args["uri"]
    @tracks_href = args["tracks"]["href"]
    @track_count = args["tracks"]["total"]
    @tracks = {}
  end

  #Pass in the connection object from the instance of User
  def get_tracks(connection_object)
    response = connection_object.request(
      "GET",
      HTTP::URI.parse(@tracks_href)
    )
    body = JSON.parse(response.body.to_s)
    lists = body["items"]
    tracks = {}
    lists.each do |track|
      trak = Track.new(track["track"])
      tracks[trak.name] = trak
    end
    @tracks = tracks
  end
end