require "rubycritic/smell"

module Rubycritic
  module SmellAdapter

    class Flog
      def initialize(flog)
        @flog = flog
      end

      def smells
        smells = []
        @flog.each_by_score do |class_method, score|
          smells << create_smell(class_method, score)
        end
        smells
      end

      private

      def create_smell(context, score)
        location = method_location(context)
        Smell.new(:locations => [location], :context => context, :score => score)
      end

      def method_location(context)
        line = @flog.method_locations[context]
        file_path, file_line = line.split(':')
        Location.new(file_path, file_line)
      end
    end

  end
end
