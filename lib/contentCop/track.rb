require_relative "./lyric_methods"
require_relative "./explicit_analysis"

class Track
  attr_accessor :explicit, :id, :name, :uri, :album, :artists, :lyrics, :explicit_results, :url_encoded_name
  def initialize(args)
    @explicit = args["explicit"]
    @id = args["id"]
    @name = args["name"]
    @name = @name.split("-")[0].strip
    @uri = args["uri"]
    @album = args["album"]
    @artists = args["artists"]
    @url_encoded_name = CGI.escape(args["name"])
  end

  def find_lyrics
    @lyrics ||= get_lyrics(@artists[0]["name"], @name)
  end

  def analyze_explicit
    find_lyrics
    @explicit_results = explicit_analyze(@lyrics)
  end
end