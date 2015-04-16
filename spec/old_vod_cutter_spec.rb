require "artifice"
require_relative "spec_helper"
require_relative "../lib/goliath/old_vod_cutter"
require_relative "artifice/twitch_endpoint"

describe Goliath::OldVodCutter do
  describe "#fetch" do
    let(:vod_cutter) { Goliath::OldVodCutter.new }
    let(:vod_id) { "645731990" }

    before do
      Artifice.activate_with(TwitchEndpoint)
    end

    it "should fetch the links" do
      links = %w(http://store118.media85.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428163437.flv
      http://store141.media95.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428165150.flv
      http://store162.media106.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428166862.flv
      http://store114.media79.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428168572.flv
      http://store148.media99.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428170284.flv
      http://store78.media60.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428171994.flv
      http://store122.media87.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428173704.flv
      http://store178.media114.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428175415.flv
      http://store53.media50.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428177126.flv
      http://store91.media67.justin.tv/archives/2015-4-4/live_user_esl_evolve_1428178837.flv)

      expect(vod_cutter.fetch(vod_id: vod_id)).to eq(links)
    end
  end
end
