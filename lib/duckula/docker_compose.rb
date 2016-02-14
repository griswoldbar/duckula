module Duckula
  class DockerCompose
    def initialize(runner)
      @runner = runner
    end
    
    def up
      invoke("up")
    end
    
    def stop
      invoke("stop")
    end

    def run(app_name, cmd)
      @runner.run(self, app_name, cmd)
    end
    
    def pull(app_name)
      invoke("pull #{app_name}")
    end
    
    def invoke(args)
      system "cd #{DUCKULA_DIR} && docker-compose #{args}"
    end
  end
end