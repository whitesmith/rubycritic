# frozen_string_literal: true

require 'reek'

module RubyCritic
  class Reek < ::Reek::Examiner
    def self.configuration
      @configuration ||= ::Reek::Configuration::AppConfiguration.from_default_path
    end

    def initialize(analysed_module)
      super(analysed_module, configuration: self.class.configuration)
    end
  end
end
