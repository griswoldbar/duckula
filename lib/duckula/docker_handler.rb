module Duckula
  class DockerHandler
    def initialize(app, docker_compose, compose_config)
      @app = app
      @dc = docker_compose
      config = compose_config[@app.name]
      QUACKER.error "no entry for #{@app.name} in docker-compose.yml" if config.nil?
      @image_name = config["image"]
    end
    
    # def update_if_stale
    #   if stale?
    #     true
    #   end
    # end
    
    def stale?
      current_image_id = docker_run(%Q{inspect --format "{{.Id}}" #{@image_name}})
      docker_run("pull #{@image_name}")
      latest_image_id = docker_run(%Q{inspect --format "{{.Id}}" #{@image_name}})
      current_image_id != latest_image_id
    end
    
    private
    def docker_run(cmd)
      system("docker #{cmd}")
    end
  end
end