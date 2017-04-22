# frozen_string_literal: true

require 'reek'

module RubyCritic
  class Reek < ::Reek::Examiner
    def initialize(analysed_module)
      super(analysed_module, configuration: ::Reek::Configuration::AppConfiguration.from_path)
    end
  end
end
