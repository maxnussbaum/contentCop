
class Track
  attr_accessor :explicit, :id, :name, :uri, :album, :artists
  def initialize(args)
    @explicit = args["explicit"]
    @id = args["id"]
    @name = args["name"]
    @uri = args["uri"]
    @album = args["album"]
    @artists = args["artists"]
  end
end