module Duckula
  class DockerCompose
    def up
      invoke("up")
    end
    
    def stop
      invoke("stop")
    end

    def run(app_name, cmd)
      invoke("run #{app_name} #{cmd}")
    end
    
    private
    def invoke(args)
      system "cd #{DUCKULA_DIR} && docker-compose #{args}"
    end
  end
end