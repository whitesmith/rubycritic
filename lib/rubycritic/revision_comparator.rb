require "rubycritic/smelly_pathnames_serializer"
require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/smells_aggregator"
require "rubycritic/smells_status_setter"

module Rubycritic

  class RevisionComparator
    SNAPSHOTS_DIR = File.expand_path("tmp/rubycritic/snapshots", Dir.getwd)

    def initialize(paths, source_control_system)
      @paths = paths
      @source_control_system = source_control_system
    end

    def compare
      SmellsStatusSetter.new(smelly_pathnames_before, smelly_pathnames_now).smelly_pathnames
    end

    private

    def smelly_pathnames_before
      serializer = SmellyPathnamesSerializer.new(revision_file)
      if File.file?(revision_file)
        serializer.load
      else
        smelly_pathnames = nil
        @source_control_system.travel_to_head do
          smelly_pathnames = smelly_pathnames(paths_of_tracked_files)
        end
        serializer.dump(smelly_pathnames)
        smelly_pathnames
      end
    end

    def smelly_pathnames_now
      smelly_pathnames(@paths)
    end

    def smelly_pathnames(paths)
      smell_adapters = AnalysersRunner.new(paths).run
      SmellsAggregator.new(smell_adapters).smelly_pathnames
    end

    def revision_file
      @revision_file ||= File.join(SNAPSHOTS_DIR, @source_control_system.head_reference)
    end

    def paths_of_tracked_files
      SourceLocator.new(["."]).paths
    end
  end

end
