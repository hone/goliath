require 'goliath/piece_namer'
require 'goliath/downloader'
require 'goliath/joiner'

module Goliath
  module BaseVod
    def initialize(vod_id:, output:)
      @vod_id = vod_id
      @output = output
    end

    def download
      dir = @output.split(".")
      dir.pop
      dir = dir.join(".")
      FileUtils.mkdir_p(dir)
      Dir.chdir(dir) do
        links     = PieceNamer.new.generate(fetch_vod_links, extension: extension)
        parts_dir = "parts"
        FileUtils.mkdir_p(parts_dir)
        Dir.chdir(parts_dir) { Downloader.new.run(links) }
        Joiner.new.build(output: @output, options: ffmpeg_options, extension: extension)
      end
      puts "Built #{dir}/#{@output}"
    end
  end
end
