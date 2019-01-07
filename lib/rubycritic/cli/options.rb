# frozen_string_literal: true

require 'rubycritic/cli/options/argv'

module RubyCritic
  module Cli
    class Options
      attr_reader :options

      def initialize(argv)
        @options = Argv.new(argv)
      end

      def parse
        options.parse
      end

      def to_h
        options.to_h
      end
    end
  end
end
