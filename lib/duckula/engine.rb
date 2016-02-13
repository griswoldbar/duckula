module Duckula
  class Engine
    def initialize(apps, docker_compose)
      @apps = apps
      @dc = docker_compose
    end
    
    def run(*args)
      send(*args)
    end
    
    def up
      @apps.each(&:fetch)
      @apps.each(&:setup_db)
      @dc.up
    end
    
    def stop
      @dc.stop
    end
    
    def reset
      @apps.each(&:reset)
    end

  end
end