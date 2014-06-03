require "rubycritic/source_control_systems/base"
require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/revision_comparator"
require "rubycritic/core/analysed_file"

module Rubycritic

  class Orchestrator
    def initialize
      @source_control_system = SourceControlSystem::Base.create
    end

    def critique(paths)
      source = SourceLocator.new(paths)
      analysed_files = source.pathnames.map do |pathname|
        AnalysedFile.new(:pathname => pathname, :smells => [])
      end
      AnalysersRunner.new(analysed_files, @source_control_system).run
      if @source_control_system.has_revision?
        RevisionComparator.new(analysed_files, @source_control_system).set_statuses
      end
      analysed_files
    end
  end

end
