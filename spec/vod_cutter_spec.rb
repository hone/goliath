require_relative "spec_helper"
require_relative "../lib/goliath/vod_cutter"

describe Goliath::VodCutter do
  describe "#fetch" do
    let(:vod_cutter) { Goliath::VodCutter.new }

    it "should Piece 1 on the page", internet: true do
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          vod_cutter.fetch(
            url:    "http://www.twitch.tv/evolvegame/v/3868953",
            start:  "00:00:00",
            finish: "08:05:56"
          )

          expect(File.read("vod_parts.html")).to include("Piece 1")
        end
      end
    end
  end
end
