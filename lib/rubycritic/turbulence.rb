require "json"

module Rubycritic

  module Turbulence
    def self.data(analysed_files)
      analysed_files.map do |analysed_file|
        {
          :name => analysed_file.pathname,
          :x => analysed_file.churn,
          :y => analysed_file.complexity
        }
      end.to_json
    end
  end

end
