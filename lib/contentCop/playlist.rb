
class Playlist
  attr_accessor :id, :name, :owner, :uri, :tracks_href, :track_count
  def initialize(args)
    @id = args["id"]
    @name = args["name"]
    @owner = args["owner"]
    @uri = args["uri"]
    @tracks_href = args["tracks"]["href"]
    @track_count = args["tracks"]["total"]
  end
end