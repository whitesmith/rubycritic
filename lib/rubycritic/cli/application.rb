# frozen_string_literal: true

require 'rubycritic'
require 'rubycritic/browser'
require 'rubycritic/cli/options'
require 'rubycritic/command_factory'

module RubyCritic
  module Cli
    class Application
      STATUS_SUCCESS = 0
      STATUS_ERROR   = 1

      def initialize(argv)
        @options = Options.new(argv)
      end

      def execute
        parsed_options = @options.parse.to_h

        reporter = RubyCritic::CommandFactory.create(parsed_options).execute
        print(reporter.status_message)
        reporter.status
      rescue OptionParser::InvalidOption => error
        warn "Error: #{error}"
        STATUS_ERROR
      end

      def print(message)
        $stdout.puts message
      end
    end
  end
end
