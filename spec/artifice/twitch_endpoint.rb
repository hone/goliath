require "sinatra"
require_relative "../helpers/path_helper"

class TwitchEndpoint < Sinatra::Base
  include PathHelper

  get "/vod/:id" do
    File.read(fixtures_path("#{params[:id]}.m3u8"))
  end

  get "/v1/AUTH_system/vods_5370/evolvegame_13456540144_214066425/chunked/index-dvr.m3u8" do
    File.read(fixtures_path("index-dvr.m3u8"))
  end
end
