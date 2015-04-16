require 'uri'
require 'net/http'
require 'm3u8'
require 'json'

module Goliath
  class VodCutter
    def initialize(sleep_time: 5)
      @sleep_time = sleep_time
    end

    def fetch(vod_id:)
      access_token = fetch_access_token(vod_id)
      m3u8_url     = fetch_hls_vod(access_token)
      fetch_vod_urls(m3u8_url)
    end

    def fetch_access_token(vod_id)
      uri = URI("https://api.twitch.tv/api/vods/#{vod_id}/access_token")
      JSON.parse(Net::HTTP.get(URI(uri)))
    end

    def fetch_hls_vod(access_token, video_type = "chunked")
      token  = JSON.parse(access_token["token"])
      vod_id = token["vod_id"]
      sig    = access_token["sig"]
      uri    = URI("http://usher.twitch.tv/vod/#{vod_id}?nauthsig=#{sig}&nauth=#{URI.encode(token.to_json)}")
      m3u8   = M3u8::Playlist.read(Net::HTTP.get(uri))

      m3u8.items.detect {|item| item.uri && item.video == video_type }.uri
    end

    def fetch_vod_urls(m3u8_url)
      uri        =  URI(m3u8_url)
      m3u8       = M3u8::Playlist.read(Net::HTTP.get(uri))
      path_parts = uri.path.split("/")[0..-2]
      m3u8.items.map do |item|
        next if item.segment == "#EXT-X-ENDLIST"
        item_path, item_query = item.segment.split("?")
        segment_uri = URI::HTTP.build(
            host: uri.host,
            path: (path_parts + [item_path]).join("/"),
            query: item_query
        )
        segment_uri.to_s
      end.compact
    end
  end
end
