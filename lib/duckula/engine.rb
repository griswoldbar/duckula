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
      setup_workspaces
      setup_dbs
      @dc.up
    end
    
    def stop
      @dc.stop
    end
    
    def migrate
      
    end
    
    private
    def setup_workspaces
      @apps.each do |app|
        Fetcher.new(app).fetch
      end
    end
    
    def setup_dbs
      @apps.each do |app|
        DbHandler.new(app, @dc).setup
      end
    end
  end
end