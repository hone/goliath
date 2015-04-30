require 'net/http'
require 'concurrent'

module Goliath
  class Downloader
    def initialize(pool_size = 5)
      @pool = Concurrent::FixedThreadPool.new(pool_size)
    end
    
    def run(links)
      links.each do |link|
        @pool.post(link) do
          uri = URI(link.href)

          Net::HTTP.start(uri.host, uri.port) do |http|
            request = Net::HTTP::Get.new uri
            request.set_range((File.size(link.name)..-1)) if File.exist?(link.name)
            http.request(request) do |response|
              File.open(link.name, 'ab') do |io|
                response.read_body {|chunk| io.write chunk }
              end
            end
          end

        end
      end

      @pool.shutdown
      @pool.wait_for_termination
    end
  end
end
