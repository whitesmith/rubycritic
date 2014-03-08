require "reek"

module Rubycritic
  module Analyser

    class Reek < ::Reek::Examiner
      DEFAULT_CONFIG_FILES = ["lib/rubycritic/analysers/config.reek"]

      def initialize(paths)
        super(Array(paths), DEFAULT_CONFIG_FILES)
      end
    end

  end
end
