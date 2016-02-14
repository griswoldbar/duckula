module Duckula
  class Reloader
    def initialize(apps, session)
      @apps = apps
      @session = session
    end
    
    def run
      puts "hai hai hai"
      sleep 10
      while true do
        # if apps.map(&:stale?).any?
          QUACKER.say("stale images detected. restarting services...")
          binding.pry
          JOBS[:engine].kill
          JOBS[:engine] = Thread.new do
            session.engine.run("up")
          end
        # end
        sleep 5
      end
    end
  end
end