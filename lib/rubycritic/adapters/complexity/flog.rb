require "rubycritic/analysers/flog"

module Rubycritic
  module ComplexityAdapter

    class Flog
      def initialize(analysed_files)
        @flog = Analyser::Flog.new
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
