require "rubycritic/configuration"
require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/source_control_systems/source_control_system"
require "rubycritic/revision_comparator"
require "rubycritic/report_generators/reporter"

module Rubycritic

  class Rubycritic
    def initialize
      @source_control_system = SourceControlSystem.create
    end

    def critique(paths)
      source = SourceLocator.new(paths)
      smells = AnalysersRunner.new(source.paths).run
      if @source_control_system.has_revision?
        smells = RevisionComparator.new(smells, @source_control_system).smells
      end
      Reporter.new(source.pathnames, smells).generate_report
    end
  end

end
