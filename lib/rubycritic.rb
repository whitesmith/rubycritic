require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/smells_aggregator"
require "rubycritic/source_control_systems/source_control_system"
require "rubycritic/revision_comparator"
require "rubycritic/report_generators/reporter"

module Rubycritic

  class Rubycritic
    def initialize(dirs)
      @source = SourceLocator.new(dirs)
      @source_control_system = SourceControlSystem.create
    end

    def critique
      smell_adapters = AnalysersRunner.new(@source.paths).run
      smelly_pathnames = SmellsAggregator.new(smell_adapters).smelly_pathnames
      Reporter.new(@source.pathnames, smelly_pathnames).generate_report
    end

    def compare
      if @source_control_system.has_revision?
        smelly_pathnames = RevisionComparator.new(@source.paths, @source_control_system).compare
        Reporter.new(@source.pathnames, smelly_pathnames).generate_report
      else
        critique
      end
    end
  end

end
