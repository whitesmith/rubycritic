require "rubycritic/analysers/reek"
require "rubycritic/smell"

module Rubycritic
  module SmellAdapter

    class Reek
      def initialize(paths)
        @reek = ::Rubycritic::Analyser::Reek.new(paths)
      end

      def smells
        @reek.smells.map do |smell|
          create_smell(smell)
        end
      end

      private

      def create_smell(smell)
        Smell.new(
          :locations => smell_locations(smell.source, smell.lines),
          :context   => smell.context,
          :message   => smell.message,
          :type      => smell.subclass
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
