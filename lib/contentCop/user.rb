require "json"
require_relative "./base_service"
require_relative "./playlist"
require_relative "./track"
require "uri"

module ContentCop
  class User < BaseService
    attr_accessor :username, :playlists, :profile
    def initialize
      super
      @username = ""
    end

    def get_user_profile
      response = @conn.request(
        "GET",
        HTTP::URI.parse(@url + "/v1/users" + "/#{@username}")
      )
      body = JSON.parse(response.body.to_s)
      @profile=body
    end

    def get_user_playlists
      response = @conn.request(
        "GET",
        HTTP::URI.parse(@url + "/v1/users/#{@username}/playlists")
      )
      body = JSON.parse(response.body.to_s)
      lists= body["items"]
      playlists = {}
      lists.each do |playlist|
        play = Playlist.new(playlist)
        playlists[play.name] = play
      end
      @playlists = playlists
    end

    def create_clean_playlist(unclean_playlist)
      response = @conn.request(
        "POST",
        @url + "/v1/users/" + @username + "/playlists",
        headers: @conn.default_options.headers.merge({
          "Content-Type" => "application/json"
        }),
        form: {
          name: "#{unclean_playlist.name} CLEAN",
          scope: "playlist-modify-public"
        }
      )
      puts response.status
      puts response.body.to_s
    end
  end
end