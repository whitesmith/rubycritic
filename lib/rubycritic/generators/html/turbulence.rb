# frozen_string_literal: true

require 'json'
module RubyCritic
  module Turbulence
    def self.data(analysed_modules)
      analysed_modules.map do |analysed_module|
        {
          name: analysed_module.name,
          x: analysed_module.churn,
          y: analysed_module.complexity,
          rating: analysed_module.rating.to_s
        }
      end.to_json
    end
  end
end
