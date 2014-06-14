require "rubycritic/serializer"
require "rubycritic/files_initializer"
require "rubycritic/analysers_runner"
require "rubycritic/smells_status_setter"

module Rubycritic

  class RevisionComparator
    SNAPSHOTS_DIR_NAME = "snapshots"

    def initialize(analysed_files, source_control_system)
      @analysed_files_now = analysed_files
      @source_control_system = source_control_system
    end

    def set_statuses
      SmellsStatusSetter.set(
        analysed_files_before.flat_map(&:smells),
        @analysed_files_now.flat_map(&:smells)
      )
    end

    private

    def analysed_files_before
      serializer = Serializer.new(revision_file)
      if File.file?(revision_file)
        serializer.load
      else
        analysed_files = FilesInitializer.init(["."])
        @source_control_system.travel_to_head do
          AnalysersRunner.new(analysed_files, @source_control_system).run
        end
        serializer.dump(analysed_files)
        analysed_files
      end
    end

    def revision_file
      @revision_file ||= File.join(
        ::Rubycritic.configuration.root,
        SNAPSHOTS_DIR_NAME,
        @source_control_system.head_reference
      )
    end
  end

end
