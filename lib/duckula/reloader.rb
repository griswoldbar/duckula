module Duckula
  class Reloader
    def initialize(apps)
      @apps = apps
    end
    
    def run
      sleep 10
        while true do
          apps.each(&:update_if_stale)
          
          WIP WIP WIP
          
          sleep 30
        end
      end
    end
  end
end