module Duckula
  class Fetcher
    def initialize(app)
      @app = app
    end
    
    def fetch
      clone_repo unless File.exists?(@app.dir)
      pull
    end
    
    private
    def clone_repo
      `(
        cd #{WORKING_DIR} 
        git clone --depth=1 #{@app.git_repo} -b#{@app.branch}
      )`
    end
    
    def pull
      `(
        cd #{@app.dir}
        git checkout #{@app.branch}
        git pull origin #{@app.branch}
      )`
    end
  end
end