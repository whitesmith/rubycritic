# frozen_string_literal: true

require 'rubycritic/serializer'
require 'rubycritic/analysers_runner'
require 'rubycritic/smells_status_setter'
require 'rubycritic/version'
require 'digest/md5'

module RubyCritic
  class RevisionComparator
    SNAPSHOTS_DIR_NAME = 'snapshots'.freeze

    def initialize(paths)
      @paths = paths
    end

    def statuses=(analysed_modules_now)
      return unless Config.source_control_system.revision?

      analysed_modules_before = load_cached_analysed_modules
      return unless analysed_modules_before

      SmellsStatusSetter.set(
        analysed_modules_before.flat_map(&:smells),
        analysed_modules_now.flat_map(&:smells)
      )
    end

    private

    def load_cached_analysed_modules
      Serializer.new(revision_file).load if File.file?(revision_file)
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
