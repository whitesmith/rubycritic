require "rubycritic/turbulence"
require "rubycritic/report_generators/reporter"

module Rubycritic

  class Orchestrator
    def initialize
      @source_control_system = SourceControlSystem.create
    end

    def critique(paths)
      source = SourceLocator.new(paths)
      smells = AnalysersRunner.new(source.paths).smells
      if @source_control_system.has_revision?
        smells = RevisionComparator.new(smells, @source_control_system).smells
        turbulence_data = Turbulence.new(source.paths, @source_control_system).data
      end
      Reporter.new(source.pathnames, smells, turbulence_data).generate_report
    end
  end

end
