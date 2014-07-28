require "rubycritic/serializer"
require "rubycritic/modules_initializer"
require "rubycritic/analysers_runner"
require "rubycritic/smells_status_setter"
require "rubycritic/version"
require "digest/md5"

module Rubycritic

  class RevisionComparator
    SNAPSHOTS_DIR_NAME = "snapshots"

    def initialize(analysed_modules, source_control_system, paths)
      @analysed_modules_now = analysed_modules
      @source_control_system = source_control_system
      @paths = paths
    end

    def set_statuses
      SmellsStatusSetter.set(
        analysed_modules_before.flat_map(&:smells),
        @analysed_modules_now.flat_map(&:smells)
      )
    end

    private

    def analysed_modules_before
      serializer = Serializer.new(revision_file)
      if File.file?(revision_file)
        serializer.load
      else
        analysed_modules = ModulesInitializer.init(@paths)
        @source_control_system.travel_to_head do
          AnalysersRunner.new(analysed_modules, @source_control_system).run
        end
        serializer.dump(analysed_modules)
        analysed_modules
      end
    end

    def revision_file
      @revision_file ||= File.join(
        ::Rubycritic.configuration.root,
        SNAPSHOTS_DIR_NAME,
        VERSION,
        Digest::MD5.hexdigest(Marshal.dump(@paths)),
        @source_control_system.head_reference
      )
    end
  end

end
