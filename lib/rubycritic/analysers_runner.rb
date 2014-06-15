require "rubycritic/adapters/smell/flay"
require "rubycritic/adapters/smell/flog"
require "rubycritic/adapters/smell/reek"
require "rubycritic/adapters/complexity/flog"
require "rubycritic/analysers/churn"
require "rubycritic/analysers/stats"

module Rubycritic

  class AnalysersRunner
    SMELL_ANALYSERS = [SmellAdapter::Flay, SmellAdapter::Flog, SmellAdapter::Reek]

    def initialize(analysed_files, source_control_system)
      @analysed_files = analysed_files
      @source_control_system = source_control_system
    end

    def run
      SMELL_ANALYSERS.map do |analyser|
        analyser.new(@analysed_files).smells
      end
      ComplexityAdapter::Flog.new(@analysed_files).complexity
      Analyser::Churn.new(@analysed_files, @source_control_system).churn
      Analyser::Stats.new(@analysed_files).stats
    end
  end

end
