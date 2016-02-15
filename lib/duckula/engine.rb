module Duckula
  class Engine
    def initialize(apps, docker_compose, reloader)
      @apps = apps
      @dc = docker_compose
      @reloader = reloader.new(apps, self)      
    end
    
    def run(*args)
      send(*args)
    end
    
    def up
      QUACKER.say("powering up...")
      @apps.each(&:docker_pull)
      @apps.each(&:fetch)
      @apps.each(&:setup_db)
      @reloader.run
      @dc.up
    end
    
    def stop
      QUACKER.say("powering down...")
      @dc.stop
    end
    
    def reset
      @apps.each(&:reset)
    end

  end
end