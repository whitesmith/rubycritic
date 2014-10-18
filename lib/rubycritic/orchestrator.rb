require "rubycritic/source_control_systems/base"
require "rubycritic/analysers_runner"
require "rubycritic/revision_comparator"

module Rubycritic

  class Orchestrator
    def initialize
      @source_control_system = SourceControlSystem::Base.create
    end

    def critique(paths)
      analysed_modules = AnalysersRunner.new(paths, @source_control_system).run
      if @source_control_system.has_revision?
        RevisionComparator.new(analysed_modules, @source_control_system, paths).set_statuses
      end
      analysed_modules
    end
  end

end
