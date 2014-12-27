require "rubycritic/analysers/helpers/reek"
require "rubycritic/core/smell"

module Rubycritic
  module Analyser

    class ReekSmells
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          add_smells_to(analysed_module)
        end
      end

      private

      def add_smells_to(analysed_module)
        Reek.new(analysed_module.path).smells.each do |smell|
          analysed_module.smells << create_smell(smell)
        end
      end

      def create_smell(smell)
        Smell.new(
          :locations => smell_locations(smell.source, smell.lines),
          :context   => smell.context,
          :message   => smell.message,
          :type      => smell.smell_type,
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
