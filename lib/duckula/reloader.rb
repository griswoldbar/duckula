module Duckula
  class Reloader
    def initialize(engine)
      @engine = engine
    end
    
    def run
      Thread.new do
        while true do
          puts "poop"
          sleep 4
        end
      end
    end
  end
end