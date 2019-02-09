require "json"
require_relative "./base_service"
require_relative "./playlist"

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
  end
end