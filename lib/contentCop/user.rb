require "json"
require_relative "./base_service"

module ContentCop
  class User < BaseService
    attr_accessor :username
    def initialize(username)
      @username = username
      super
    end

    def get_user_profile
      response = @conn.request(
        "GET",
        HTTP::URI.parse(@url + "/v1/users" + "/#{@username}")
      )
      body = JSON.parse(response.body.to_s)
      puts body
    end

    def get_user_playlists
      response = @conn.request(
        "GET",
        HTTP::URI.parse(@url + "/v1/users/#{@username}/playlists")
      )
      body = JSON.parse(response.body.to_s)
      puts body
    end
  end
end