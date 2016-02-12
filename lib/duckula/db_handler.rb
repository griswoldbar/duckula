module Duckula
  class DbHandler
    def initialize(app, dc)
      @app = app
      @dc = dc
    end
    
    def setup
      unless running?
        create_and_migrate
      end
    end
    
    private
    def running?
      @dc.run(@app.name, %Q{bash -c "bundle exec rake db:migrate:status 2>/dev/null"})
    end
    
    def create_and_migrate
      @dc.run(@app.name, %Q{bash -c "bundle exec rake db:create db:schema:load"})
    end
  end
end