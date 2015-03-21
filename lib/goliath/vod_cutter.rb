require 'capybara/poltergeist'

module Goliath
  class VodCutter
    include Capybara::DSL

    VOD_CUTTER_URL = "http://www.twitch-vod-cutter.appspot.com/"
    TimeStruct = Struct.new(:hour, :minute, :second)

    def initialize(sleep_time: 5)
      Capybara.current_driver = :poltergeist
      @sleep_time = sleep_time
    end

    def fetch(url:, start:, finish:)
      start_time  = construct_time(start)
      finish_time = construct_time(finish)

      visit(VOD_CUTTER_URL)
      find("input[ng-model='vod_id']").set(url)
      find("input[ng-model='sh']").set(start_time.hour)
      find("input[ng-model='sm']").set(start_time.minute)
      find("input[ng-model='ss']").set(start_time.second)
      find("input[ng-model='eh']").set(finish_time.hour)
      find("input[ng-model='em']").set(finish_time.minute)
      find("input[ng-model='es']").set(finish_time.second)
      find("button").click
      sleep(@sleep_time) # wait for javascript to finish executing
      save_page("vod_parts.html")
    end

    private
    def construct_time(time)
      hour, minute, second = time.split(":")
      TimeStruct.new(hour, minute, second)
    end
  end
end
