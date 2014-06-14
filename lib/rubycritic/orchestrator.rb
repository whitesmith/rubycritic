require "rubycritic/source_control_systems/base"
require "rubycritic/files_initializer"
require "rubycritic/analysers_runner"
require "rubycritic/revision_comparator"

module Rubycritic

  class Orchestrator
    def initialize
      @source_control_system = SourceControlSystem::Base.create
    end

    def critique(paths)
      analysed_files = FilesInitializer.init(paths)
      AnalysersRunner.new(analysed_files, @source_control_system).run
      if @source_control_system.has_revision?
        RevisionComparator.new(analysed_files, @source_control_system).set_statuses
      end
      analysed_files
    end
  end

end
