require_relative "./lyric_methods"
require_relative "./explicit_analysis"

class Track
  attr_accessor :explicit, :id, :name, :uri, :album, :artists, :lyrics, :explicit_results
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

  def analyze_explicit
    find_lyrics
    puts @name
    @explicit_results = explicit_analyze(@lyrics)
  end
end