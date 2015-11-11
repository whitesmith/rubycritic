require "rubycritic/analysers/helpers/reek"
require "rubycritic/core/smell"

module Rubycritic
  module Analyser

    class ReekSmells
      REEK_WIKI = "https://github.com/troessner/reek/wiki/"

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
        Reek.new(analysed_module.pathname).smells.each do |smell|
          analysed_module.smells << create_smell(smell)
        end
      end

      def create_smell(smell)
        Smell.new(
          :locations      => smell_locations(smell.source, smell.lines),
          :context        => smell.context,
          :message        => smell.message,
          :type           => smell.smell_type,
          :documentation  => smell_documentation(smell.smell_type),
          :cost           => 0
        )
      end

      def smell_locations(file_path, file_lines)
        file_lines.uniq.map do |file_line|
          Location.new(file_path, file_line)
        end.sort
      end

      def smell_documentation(smell_type)
        REEK_WIKI + smell_type.gsub(/([a-z\d])([A-Z])/, '\1-\2')
      end
    end

  end
end
