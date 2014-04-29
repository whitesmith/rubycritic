require "rubycritic/smells_serializer"
require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/smells_aggregator"
require "rubycritic/smells_status_setter"

module Rubycritic

  class RevisionComparator
    SNAPSHOTS_DIR = File.expand_path("tmp/rubycritic/snapshots", Dir.getwd)

    def initialize(smells, source_control_system)
      @smells_now = smells
      @source_control_system = source_control_system
    end

    def smells
      SmellsStatusSetter.new(smells_before, @smells_now).smells
    end

    private

    def smells_before
      serializer = SmellsSerializer.new(revision_file)
      if File.file?(revision_file)
        serializer.load
      else
        smells = nil
        @source_control_system.travel_to_head do
          smell_adapters = AnalysersRunner.new(paths_of_tracked_files).run
          smells = SmellsAggregator.new(smell_adapters).smells
        end
        serializer.dump(smells)
        smells
      end
    end

    def revision_file
      @revision_file ||= File.join(SNAPSHOTS_DIR, @source_control_system.head_reference)
    end

    def paths_of_tracked_files
      SourceLocator.new(["."]).paths
    end
  end

end
