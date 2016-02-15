module Duckula
  class App
    attr_reader :name, :branch, :git_repo, :dir
    
    def initialize(
        name:,
        config:,
        compose_config:,
        docker_compose:,
        db_handler:,
        git_handler:,
        docker_handler:
      )
      @name = name
      @branch = config["branch"]
      @git_repo = config["git_repo"]
      @dir = "#{WORKING_DIR}/#{@name}"
      @dc = docker_compose
      @db_handler = db_handler.new(self, @dc)
      @git_handler = git_handler.new(self)
      @docker_handler = docker_handler.new(self, @dc, compose_config)
    end
    
    def docker_pull
      @dc.pull(self.name)
    end
    
    def fetch
      @git_handler.fetch
      system(%Q{rm "#{@dir}/tmp/pids/server.pid"})
    end
    
    def setup_db
      @db_handler.setup
    end
    
    def reset
      @db_handler.reset
    end

    def stale?
      @docker_handler.stale?
    end
  end
end