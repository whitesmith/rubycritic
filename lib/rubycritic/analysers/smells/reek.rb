require "rubycritic/analysers/adapters/reek"
require "rubycritic/core/smell"

module Rubycritic
  module Analyser

    class ReekSmells
      def initialize(analysed_files)
        @analysed_files = analysed_files
      end

      def run
        @analysed_files.each do |analysed_file|
          add_smells_to(analysed_file)
        end
      end

      private

      def add_smells_to(analysed_file)
        Reek.new(analysed_file.path).smells.each do |smell|
          analysed_file.smells << create_smell(smell)
        end
      end

      def create_smell(smell)
        Smell.new(
          :locations => smell_locations(smell.source, smell.lines),
          :context   => smell.context,
          :message   => smell.message,
          :type      => smell.subclass,
          :cost      => 0
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
