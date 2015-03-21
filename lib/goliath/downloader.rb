require 'concurrent'

module Goliath
  class Downloader
    def initialize(pool_size = 5)
      @pool = Concurrent::FixedThreadPool.new(pool_size)
    end
    
    def run(links)
      links.each do |link|
        @pool.post(link) do
          `curl -o #{link.name} -s -S "#{link.href}"`
        end
      end

      @pool.shutdown
      @pool.wait_for_termination
    end
  end
end
