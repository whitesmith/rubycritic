require "rubycritic/smells_serializer"
require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/smells_status_setter"

module Rubycritic

  class RevisionComparator
    SNAPSHOTS_DIR_NAME = "snapshots"

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
          smells = AnalysersRunner.new(paths_of_tracked_files).smells
        end
        serializer.dump(smells)
        smells
      end
    end

    def revision_file
      @revision_file ||= File.join(
        ::Rubycritic.configuration.root,
        SNAPSHOTS_DIR_NAME,
        @source_control_system.head_reference
      )
    end

    def paths_of_tracked_files
      SourceLocator.new(["."]).paths
    end
  end

end
