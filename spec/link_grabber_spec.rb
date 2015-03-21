require_relative "spec_helper"
require_relative "../lib/goliath/link_grabber"

describe Goliath::LinkGrabber do
  describe "#grab" do
    let(:page) { File.expand_path(File.dirname(__FILE__) + "/fixtures/vod_parts.html") }
    let(:link_grabber) { Goliath::LinkGrabber.new }

    it "should collect all the links" do
      links = link_grabber.grab(page)

      expect(links.size).to eq(510)
    end

    it "a link should contain a href and a name" do
      link = link_grabber.grab(page).first

      expect(link.href).to eq("http://vod.ak.hls.ttvnw.net/v1/AUTH_system/vods_5370/evolvegame_13456540144_214066425/chunked/index-0000000014-n2GZ.ts?start_offset=0&end_offset=14060895")
      expect(link.name).to eq("piece001.ts")
    end
  end
end
