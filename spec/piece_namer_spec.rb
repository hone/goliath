require_relative "spec_helper"
require_relative "../lib/goliath/piece_namer"

describe Goliath::PieceNamer do
  describe "#name" do
    let(:foo) { Goliath::PieceNamer.new }

    it "should generate name pieces with a single digit if less than 10 items" do
      pieces = (1..5).to_a
      result = [
        Goliath::PieceNamer::LinkStruct.new(1, "piece1.ts"),
        Goliath::PieceNamer::LinkStruct.new(2, "piece2.ts"),
        Goliath::PieceNamer::LinkStruct.new(3, "piece3.ts"),
        Goliath::PieceNamer::LinkStruct.new(4, "piece4.ts"),
        Goliath::PieceNamer::LinkStruct.new(5, "piece5.ts")
      ]
      expect(foo.generate(pieces)).to eq(result)
    end

    it "should generate names padded by 0" do
      pieces = (1..10).to_a
      result = [
        Goliath::PieceNamer::LinkStruct.new(1,  "piece01.ts"),
        Goliath::PieceNamer::LinkStruct.new(2,  "piece02.ts"),
        Goliath::PieceNamer::LinkStruct.new(3,  "piece03.ts"),
        Goliath::PieceNamer::LinkStruct.new(4,  "piece04.ts"),
        Goliath::PieceNamer::LinkStruct.new(5,  "piece05.ts"),
        Goliath::PieceNamer::LinkStruct.new(6,  "piece06.ts"),
        Goliath::PieceNamer::LinkStruct.new(7,  "piece07.ts"),
        Goliath::PieceNamer::LinkStruct.new(8,  "piece08.ts"),
        Goliath::PieceNamer::LinkStruct.new(9,  "piece09.ts"),
        Goliath::PieceNamer::LinkStruct.new(10, "piece10.ts")
      ]
      expect(foo.generate(pieces)).to eq(result)
    end
  end
end
