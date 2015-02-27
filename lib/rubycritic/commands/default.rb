require "rubycritic/source_control_systems/base"
require "rubycritic/analysers_runner"
require "rubycritic/revision_comparator"
require "rubycritic/reporter"

module Rubycritic
  module Command
    class Default
      def initialize(paths)
        @paths = paths
        Config.source_control_system = SourceControlSystem::Base.create
      end

      def execute
        report(critique)
      end

      def critique
        analysed_modules = AnalysersRunner.new(@paths).run
        RevisionComparator.new(@paths).set_statuses(analysed_modules)
      end

      def report(analysed_modules)
        Reporter.generate_report(analysed_modules)
      end
    end
  end
end
