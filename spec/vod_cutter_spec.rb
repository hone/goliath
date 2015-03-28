require "artifice"
require "json"
require_relative "spec_helper"
require_relative "../lib/goliath/vod_cutter"
require_relative "artifice/twitch_endpoint"

describe Goliath::VodCutter do
  describe "#fetch" do
    let(:vod_cutter) { Goliath::VodCutter.new }
    let(:vod_id) { "3868953" }

    it "should fetch_access_token", internet: true do
      json = vod_cutter.fetch_access_token(vod_id)

      ["token", "sig"].each do |key|
        expect(json.keys).to include(key)
      end
    end

    it "should fetch the hls vod for chunked video", internet: true do
      access_token = vod_cutter.fetch_access_token(vod_id)
      expect(vod_cutter.fetch_hls_vod(access_token).uri).to include("/chunked/index-dvr.m3u8")
    end

    context "mocked http calls" do
      before do
        Artifice.activate_with(TwitchEndpoint)
      end

      describe "#fetch_hls_vod" do
        let(:access_token) { JSON.parse(File.read(fixtures_path("#{vod_id}_access_token.json"))) }

        it "should fetch the hls vod for chunked video" do
          expect(vod_cutter.fetch_hls_vod(access_token)).to include("/chunked/index-dvr.m3u8")
        end
      end

      describe "#fetch_vod_urls" do
        let(:m3u8_url) { "http://vod.ak.hls.ttvnw.net/v1/AUTH_system/vods_5370/evolvegame_13456540144_214066425/chunked/index-dvr.m3u8" }
        let(:answer) {
          files = %w(
            index-0000000014-n2GZ.ts?start_offset=0&end_offset=1092091
            index-0000000014-n2GZ.ts?start_offset=1092092&end_offset=2377823
            index-0000000014-n2GZ.ts?start_offset=2377824&end_offset=2977731
            index-0000000014-n2GZ.ts?start_offset=2977732&end_offset=4301815
            index-0000000014-n2GZ.ts?start_offset=4301816&end_offset=4883111
            index-0000000014-n2GZ.ts?start_offset=4883112&end_offset=6579435
            index-0000000014-n2GZ.ts?start_offset=6579436&end_offset=7542747
            index-0000000014-n2GZ.ts?start_offset=7542748&end_offset=8963087
            index-0000000014-n2GZ.ts?start_offset=8963088&end_offset=9432899
            index-0000000014-n2GZ.ts?start_offset=9432900&end_offset=9943695
            index-0000000014-n2GZ.ts?start_offset=9943696&end_offset=10558455
            index-0000000014-n2GZ.ts?start_offset=10558456&end_offset=11393927
            index-0000000014-n2GZ.ts?start_offset=11393928&end_offset=12191799
            index-0000000014-n2GZ.ts?start_offset=12191800&end_offset=13112999
            index-0000000014-n2GZ.ts?start_offset=13113000&end_offset=14060895
            index-0000000029-0dQb.ts?start_offset=0&end_offset=1417331
          )
          index = 0
          files.map do |f|
            index += 1
            Goliath::VodCutter::LinkStruct.new("http://vod.ak.hls.ttvnw.net/v1/AUTH_system/vods_5370/evolvegame_13456540144_214066425/chunked/#{f}", "piece#{index.to_s.rjust(3, "0")}.ts")
          end
        }

        it "should generate vod urls to download" do
          expect(vod_cutter.fetch_vod_urls(m3u8_url)).to eq(answer)
        end
      end
    end
  end
end
