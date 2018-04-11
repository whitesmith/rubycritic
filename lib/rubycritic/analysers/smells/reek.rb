# frozen_string_literal: true

require 'rubycritic/analysers/helpers/reek'
require 'rubycritic/core/smell'
require 'rubycritic/colorize'

module RubyCritic
  module Analyser
    class ReekSmells
      include Colorize
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          add_smells_to(analysed_module)
          print green '.'
        end
        puts ''
      end

      def to_s
        'reek smells'
      end

      private

      def add_smells_to(analysed_module)
        Reek.new(analysed_module.pathname).smells.each do |smell|
          analysed_module.smells << create_smell(smell)
        end
      end

      def create_smell(smell)
        Smell.new(
          locations: smell_locations(smell.source, smell.lines),
          context: smell.context,
          message: smell.message,
          type: smell.smell_type,
          analyser: 'reek',
          cost: 0
        )
      end

      def smell_locations(file_path, file_lines)
        file_lines.uniq.map do |file_line|
          Location.new(file_path, file_line)
        end.sort
      end
    end
  end
end
