require "rubycritic/serializer"
require "rubycritic/analysers_runner"
require "rubycritic/smells_status_setter"
require "rubycritic/version"
require "digest/md5"

module Rubycritic

  class RevisionComparator
    SNAPSHOTS_DIR_NAME = "snapshots"

    def initialize(paths)
      @paths = paths
    end

    def set_statuses(analysed_modules_now)
      if Config.source_control_system.revision?
        SmellsStatusSetter.set(
          analysed_modules_before.flat_map(&:smells),
          analysed_modules_now.flat_map(&:smells)
        )
      end
      analysed_modules_now
    end

    private

    def analysed_modules_before
      serializer = Serializer.new(revision_file)
      if File.file?(revision_file)
        serializer.load
      else
        analysed_modules = nil
        Config.source_control_system.travel_to_head do
          analysed_modules = AnalysersRunner.new(@paths).run
        end
        serializer.dump(analysed_modules)
        analysed_modules
      end
    end

    def revision_file
      @revision_file ||= File.join(
        Config.root,
        SNAPSHOTS_DIR_NAME,
        VERSION,
        Digest::MD5.hexdigest(Marshal.dump(@paths)),
        Config.source_control_system.head_reference
      )
    end
  end

end
