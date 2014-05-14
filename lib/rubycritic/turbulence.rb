require "json"

module Rubycritic

  class Turbulence
    def initialize(analysed_files)
      @analysed_files = analysed_files
    end

    def data
      @analysed_files.map do |analysed_file|
        {
          :name => analysed_file.pathname,
          :x => analysed_file.churn,
          :y => analysed_file.complexity
        }
      end.to_json
    end
  end

end
