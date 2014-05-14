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
        churn = Analyser::Churn.new(source.paths, @source_control_system).churn
      end
      complexity = ComplexityAdapter::Flog.new(source.paths).complexity
      analysed_files = AnalysedFilesBuilder.new(source.pathnames, smells, churn, complexity).analysed_files
      Reporter.new(analysed_files, smells).generate_report
    end
  end

end
