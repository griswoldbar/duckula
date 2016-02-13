module Duckula
  class DbHandler
    def initialize(app, dc)
      @app = app
      @dc = dc
    end
    
    def setup
      if db_exists?
        rake_run("db:migrate")
      else
        rake_run("db:setup")
      end
    end
    
    def reset
      rake_run("db:reset")
    end
    
    private
    def db_exists?
      rake_run("db:migrate:status 2>/dev/null")
    end
    
    def rake_run(cmd)
      @dc.run(@app.name, "bundle exec rake #{cmd}")
    end
  end
end