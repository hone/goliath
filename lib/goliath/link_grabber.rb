require 'nokogiri'

module Goliath
  class LinkGrabber
    LinkStruct = Struct.new(:href, :name)

    def grab(page)
      doc = Nokogiri::HTML(File.read(page))
      doc.css("a").map do |link|
        text, number = link.text.split
        name = "#{text.downcase}#{number.rjust(3, "0")}.ts"
        LinkStruct.new(link[:href], name)
      end
    end
  end
end
