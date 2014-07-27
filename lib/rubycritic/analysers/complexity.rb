require "rubycritic/analysers/helpers/flog"

module Rubycritic
  module Analyser

    class Complexity
      def initialize(analysed_modules)
        @flog = Flog.new
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          @flog.reset
          @flog.flog(analysed_module.path)
          analysed_module.complexity = @flog.total_score.round
        end
      end
    end

  end
end
