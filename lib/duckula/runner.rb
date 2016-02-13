module Duckula
  class Runner
    def run(dc, app_name, cmd)
      dc.invoke(%Q{run #{app_name} bash -c "#{cmd}"})
    end
  end
end