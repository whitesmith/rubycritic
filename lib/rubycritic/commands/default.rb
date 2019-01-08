# frozen_string_literal: true

require 'rubycritic/source_control_systems/base'
require 'rubycritic/analysers_runner'
require 'rubycritic/revision_comparator'
require 'rubycritic/reporter'
require 'rubycritic/commands/base'

module RubyCritic
  module Command
    class Default < Base
      def initialize(options)
        super
        @paths = options[:paths] || ['.']
        Config.source_control_system = SourceControlSystem::Base.create
      end

      def execute
        report(critique)
        status_reporter
      end

      def critique
        analysed_modules = AnalysersRunner.new(paths).run
        RevisionComparator.new(paths).statuses = analysed_modules
      end

      def report(analysed_modules)
        Reporter.generate_report(analysed_modules)
        status_reporter.score = analysed_modules.score
      end

      private

      attr_reader :paths, :status_reporter
    end
  end
end
