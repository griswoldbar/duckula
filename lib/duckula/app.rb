module Duckula
  class App
    attr_reader :name, :branch, :git_repo, :dir
    
    def initialize(
        name:,
        config:,
        compose_config:,
        docker_compose:,
        db_handler:,
        fetcher:,
        docker_handler:
      )
      @name = name
      @branch = config["branch"]
      @git_repo = config["git_repo"]
      @dir = "#{WORKING_DIR}/#{@name}"
      @dc = docker_compose
      @db_handler = db_handler.new(self, @dc)
      @fetcher = fetcher.new(self)
      @docker_handler = docker_handler.new(self, @dc, compose_config)
    end
    
    def docker_pull
      @dc.pull(self.name)
    end
    
    def fetch
      @fetcher.fetch
    end
    
    def setup_db
      @db_handler.setup
    end
    
    def reset
      @db_handler.reset
    end
    
    def update_if_stale
      @docker_handler.update_if_stale
    end
  end
end