require 'goliath/base_vod'
require 'goliath/vod_cutter'

module Goliath
  class Vod
    include BaseVod

    EXTENSION      = "ts"
    FFMPEG_OPTIONS = nil

    private
    def fetch_vod_links
      VodCutter.new.fetch(vod_id: @vod_id)
    end

    def extension
      EXTENSION
    end

    def ffmpeg_options
      FFMPEG_OPTIONS
    end
  end
end
