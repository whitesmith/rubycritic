# frozen_string_literal: true

require 'rubycritic/commands/status_reporter'

module RubyCritic
  module Command
    class Base
      def initialize(options)
        @options = options
        @status_reporter = RubyCritic::Command::StatusReporter.new(@options)
      end

      def execute
        raise NotImplementedError
      end
    end
  end
end
