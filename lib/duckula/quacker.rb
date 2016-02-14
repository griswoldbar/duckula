module Duckula
  class Quacker
    def say(str, level=1)
      puts ("="*level) + "> quack! #{str} quack!"
    end
    
    def error(str)
      puts "QUACK! #{str}"
      exit 1
    end
  end
end