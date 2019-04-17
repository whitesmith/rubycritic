# frozen_string_literal: true

require 'rubycritic/cli/options/argv'
require 'rubycritic/cli/options/file'

module RubyCritic
  module Cli
    class Options
      attr_reader :argv_options, :file_options

      def initialize(argv)
        @argv_options = Argv.new(argv)
        @file_options = File.new
      end

      def parse
        argv_options.parse
        file_options.parse
        self
      end

      # :reek:NilCheck
      def to_h
        file_hash = file_options.to_h
        argv_hash = argv_options.to_h

        file_hash.merge(argv_hash) do |_, file_option, argv_option|
          argv_option.nil? ? file_option : argv_option
        end
      end
    end
  end
end
