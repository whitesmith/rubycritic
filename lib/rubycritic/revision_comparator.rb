require "rubycritic/source_control_systems/source_control_system"
require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/smells_aggregator"
require "rubycritic/smells_status_setter"

module Rubycritic

  class RevisionComparator
    def initialize(paths)
      @paths = paths
      @source_control_system = SourceControlSystem.create
    end

    def compare
      SmellsStatusSetter.new(smelly_pathnames_before, smelly_pathnames_now).smelly_pathnames
    end

    private

    def smelly_pathnames_before
      smelly_pathnames = nil
      @source_control_system.travel_to_head do
        smelly_pathnames = smelly_pathnames(paths_of_tracked_files)
      end
      smelly_pathnames
    end

    def smelly_pathnames_now
      smelly_pathnames(@paths)
    end

    def smelly_pathnames(paths)
      smell_adapters = AnalysersRunner.new(paths).run
      SmellsAggregator.new(smell_adapters).smelly_pathnames
    end

    def paths_of_tracked_files
      SourceLocator.new(["."]).paths
    end
  end

end
