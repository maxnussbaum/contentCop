
require_relative "./lyric_methods"

class Track
  attr_accessor :explicit, :id, :name, :uri, :album, :artists, :lyrics
  def initialize(args)
    @explicit = args["explicit"]
    @id = args["id"]
    @name = args["name"]
    @uri = args["uri"]
    @album = args["album"]
    @artists = args["artists"]
  end

  def find_lyrics
    @lyrics ||= get_lyrics(@artists[0]["name"], @name)
  end
end