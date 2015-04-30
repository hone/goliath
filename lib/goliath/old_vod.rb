require 'goliath/base_vod'
require 'goliath/old_vod_cutter'

module Goliath
  class OldVod
    include BaseVod

    EXTENSION      = "flv"
    FFMPEG_OPTIONS = "-bsf:v h264_mp4toannexb"

    private
    def fetch_vod_links
      OldVodCutter.new.fetch(vod_id: @vod_id)
    end

    def extension
      EXTENSION
    end

    def ffmpeg_options
      FFMPEG_OPTIONS
    end
  end
end
