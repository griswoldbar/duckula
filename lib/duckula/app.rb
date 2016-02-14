module Duckula
  class App
    attr_reader :name, :branch, :git_repo, :dir
    
    def initialize(name, options, docker_compose, db_handler, fetcher)
      @name = name
      @branch = options["branch"]
      @git_repo = options["git_repo"]
      @dir = "#{WORKING_DIR}/#{@name}"
      @dc = docker_compose
      @db_handler = db_handler.new(self, @dc)
      @fetcher = fetcher.new(self)
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
  end
end