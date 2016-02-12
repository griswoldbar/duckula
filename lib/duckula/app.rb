module Duckula
  class App
    attr_reader :name, :branch, :git_repo, :dir
    
    def initialize(name, options)
      @name = name
      @branch = options["branch"]
      @git_repo = options["git_repo"]
      @dir = "#{WORKING_DIR}/#{@name}"
    end
  end
end