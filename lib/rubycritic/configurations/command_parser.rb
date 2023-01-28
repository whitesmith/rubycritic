# frozen_string_literal: true

module RubyCritic
  module Configurations
    class CommandParser
      COMMAND_CLASS_MODES = %i[version help ci compare default].freeze

      def initialize(mode)
        @mode = mode.to_s.split('_').first.to_sym
      end

      def parse
        COMMAND_CLASS_MODES.include?(@mode) ? @mode : :default
      end
    end
  end
end
