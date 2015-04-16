module Goliath
  class PieceNamer
    LinkStruct = Struct.new(:href, :name)

    def generate(pieces, extension: "ts")
      index      = 0
      pad_amount = pieces.size.to_s.length

      pieces.map do |piece|
        index += 1
        name   = "piece#{index.to_s.rjust(pad_amount, "0")}.#{extension}"
        LinkStruct.new(piece, name)
      end
    end
  end
end
