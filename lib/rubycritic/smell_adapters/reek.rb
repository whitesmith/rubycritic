require "rubycritic/smell"

module Rubycritic
  module SmellAdapter

    class Reek
      def initialize(reek)
        @reek = reek
      end

      def smells
        @reek.smells.map do |smell|
          create_smell(smell)
        end
      end

      private

      def create_smell(smell)
        locations = smell_locations(smell.source, smell.lines)
        message   = smell.message
        context   = smell.context
        type      = smell.subclass
        Smell.new(:locations => locations, :context => context, :message => message, :type => type)
      end

      def smell_locations(file_path, file_lines)
        file_lines.uniq.map do |file_line|
          Location.new(file_path, file_line)
        end
      end
    end

  end
end
