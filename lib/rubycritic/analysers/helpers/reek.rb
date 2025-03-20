# frozen_string_literal: true

require 'reek'

module RubyCritic
  class Reek < ::Reek::Examiner
    # Class variable to store configuration
    @@configuration = nil
    def initialize(analysed_module)
      # Load configuration once and reuse
      @@configuration ||= ::Reek::Configuration::AppConfiguration.from_default_path
      super(analysed_module, configuration: @@configuration)
    end
  end
end
