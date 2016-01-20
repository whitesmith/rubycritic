require "rubycritic/commands/status_reporter"

module Rubycritic
  module Command
    class Base
      def initialize(options)
        @options = options
        @status_reporter = Rubycritic::Command::StatusReporter.new(@options)
      end

      def execute
        raise NotImplementedError
      end
    end
  end
end
