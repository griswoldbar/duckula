module Duckula
  class DbHandler
    def initialize(app, dc)
      @app = app
      @dc = dc
    end
    
    def setup
      QUACKER.say("setting up db...")
      if db_exists?
        QUACKER.say("db found!",2)
        QUACKER.say("migrating db...",2)
        rake_run("db:migrate")
      else
        QUACKER.say("no db found!",2)
        QUACKER.say("setting up db...",2)
        rake_run("db:setup")
      end
    end
    
    def reset
      QUACKER.say("resetting db...")
      rake_run("db:reset")
    end
    
    private
    def db_exists?
      QUACKER.say("checking for db...",2)
      rake_run("db:migrate:status 2>/dev/null")
    end
    
    def rake_run(cmd)
      @dc.run(@app.name, "bundle exec rake #{cmd}")
    end
  end
end