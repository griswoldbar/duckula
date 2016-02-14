require 'app'
require 'db_handler'
require 'docker_compose'
require 'engine'
require 'fetcher'
require 'quacker'
require 'runner'
require 'reloader'

QUACKER = Duckula::Quacker.new
ROOT = `printf $PWD`
WORKING_DIR = "#{ROOT}/duckula/tmp"
DUCKULA_DIR = "#{ROOT}/duckula"

module Duckula
  class Session
    def initialize
      config_file = "#{ROOT}/duckula/duckula.yml"


      unless File.exist?(config_file)
        QUACKER.error "expected to find configuration file in #{config_file}"
        exit 1
      end

      FileUtils.mkdir_p(WORKING_DIR)

      docker_compose = DockerCompose.new(Runner.new)
      apps = YAML.load_file(config_file).each_pair.map do |k,v|
        App.new(k,v,docker_compose,DbHandler,Fetcher)
      end
      
      @engine = Engine.new(apps, docker_compose)
      @reloader = Reloader.new(@engine)
      @reloader.run
    end
    
    def run(*args)
      @engine.run(*args)
    end
    
    def stop
      @engine.stop
    end
  end
end