# frozen_string_literal: true
require 'rubycritic/core/analysed_modules_collection'
require 'rubycritic/analysers/smells/flay'
require 'rubycritic/analysers/smells/flog'
require 'rubycritic/analysers/smells/reek'
require 'rubycritic/analysers/complexity'
require 'rubycritic/analysers/churn'
require 'rubycritic/analysers/attributes'
require 'rubycritic/analysers/logger'

module RubyCritic
  class AnalysersRunner
    ANALYSERS = [
      Analyser::FlaySmells,
      Analyser::FlogSmells,
      Analyser::ReekSmells,
      Analyser::Complexity,
      Analyser::Attributes,
      Analyser::Churn
    ].freeze

    def initialize(paths)
      @paths = paths
    end

    def run
      logger = Analyser::Logger.new(analysed_modules.size * ANALYSERS.size)
      ANALYSERS.each do |analyser_class|
        analyser_instance = analyser_class.new(analysed_modules, logger)
        logger.topic = analyser_instance

        analyser_instance.run
      end

      puts ''

      analysed_modules
    end

    def analysed_modules
      @analysed_modules ||= AnalysedModulesCollection.new(@paths)
    end
  end
end
