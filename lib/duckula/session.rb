require 'app'
require 'db_handler'
require 'docker_compose'
require 'engine'
require 'git_handler'
require 'quacker'
require 'runner'
require 'reloader'
require 'docker_handler'

QUACKER = Duckula::Quacker.new
ROOT = `printf $PWD`
WORKING_DIR = "#{ROOT}/duckula/tmp"
DUCKULA_DIR = "#{ROOT}/duckula"

module Duckula
  class Session
    attr_reader :engine
    
    def initialize
      config_file = "#{ROOT}/duckula/duckula.yml"
      compose_file = "#{ROOT}/duckula/docker-compose.yml"
      
      unless File.exist?(config_file)
        QUACKER.error "expected to find duckula configuration file in #{config_file}"
        exit 1
      end
      
      unless File.exist?(compose_file)
        QUACKER.error "expected to find docker-compose configuration file in #{compose_file}"
        exit 1
      end

      FileUtils.mkdir_p(WORKING_DIR)

      docker_compose = DockerCompose.new(Runner.new)
      compose_config = YAML.load_file(compose_file)
      apps = YAML.load_file(config_file).each_pair.map do |k,v|
        App.new(
          name: k,
          config: v,
          compose_config: compose_config,
          docker_compose: docker_compose,
          db_handler: DbHandler,
          git_handler: GitHandler,
          docker_handler: DockerHandler
        )
      end
      
      @engine = Engine.new(apps, docker_compose, Reloader)
    end
    
    def run(*args)
      @engine.run(*args)
    end
    
    def stop
      @engine.stop
    end
  end
end