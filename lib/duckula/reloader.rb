module Duckula
  class Reloader
    def initialize(apps, session)
      @apps = apps
      @session = session
    end
    
    def run
      #... not implemented yet
      # Thread.new do
      #   puts "reloader here..."
      #   sleep 10
      #   while true do
      #     # if apps.map(&:stale?).any?
      #       QUACKER.say("stale images detected. restarting services...")
      #       # system(%Q{ echo "going to run kill -SIGINT #{Process.pid} && #{DUCKULA} up")
      #       
      #       IO.popen "kill -s INT '#{Process.pid}' && #{DUCKULA} up"
      # 
      #     # end
      #     sleep 10
      #   end
      # end
    end
  end
end