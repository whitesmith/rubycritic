require "json"

module Rubycritic

  module Turbulence
    def self.data(analysed_modules)
      analysed_modules.map do |analysed_module|
        {
          :name => analysed_module.name,
          :x => analysed_module.churn,
          :y => analysed_module.complexity
        }
      end.to_json
    end
  end

end
