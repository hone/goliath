module Goliath
  class Joiner
    def build(output:, options:, extension: "ts")
      links = Dir.glob("parts/*.#{extension}").sort
      construct_index(links)
      `ffmpeg -f concat -i index.txt -c copy #{options} #{output}`
    end

    private
    def construct_index(links)
      File.open("index.txt", "w") do |file|
        links.each do |link|
          file.puts "file '#{link}'"
        end
      end
    end
  end
end
