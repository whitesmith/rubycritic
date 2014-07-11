require "rubycritic/analysers/adapters/flog"

module Rubycritic
  module Analyser

    class Complexity
      def initialize(analysed_files)
        @flog = Flog.new
        @analysed_files = analysed_files
      end

      def run
        @analysed_files.each do |analysed_file|
          @flog.reset
          @flog.flog(analysed_file.path)
          analysed_file.complexity = @flog.total_score.round
        end
      end
    end

  end
end
