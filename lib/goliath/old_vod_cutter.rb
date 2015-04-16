require 'uri'
require 'net/http'
require 'json'

module Goliath
  class OldVodCutter
    API_URL = "http://api.twitch.tv/api/videos/"

    def fetch(vod_id:)
      uri = URI("#{API_URL}/a#{vod_id}")
      json = JSON.parse(Net::HTTP.get(uri))
      json["chunks"]["live"].map {|h| h["url"] }
    end
  end
end
