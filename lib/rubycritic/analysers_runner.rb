require "rubycritic/active_support/methods"
require "rubycritic/adapters/smell/flay"
require "rubycritic/adapters/smell/flog"
require "rubycritic/adapters/smell/reek"
require "rubycritic/adapters/complexity/flog"
require "rubycritic/analysers/churn"

module Rubycritic

  class AnalysersRunner
    include ActiveSupport

    SMELL_ANALYSERS = ["Flay", "Flog", "Reek"]

    def initialize(analysed_files, source_control_system)
      @analysed_files = analysed_files
      @source_control_system = source_control_system
    end

    def run
      SMELL_ANALYSERS.map do |analyser_name|
        constantize("Rubycritic::SmellAdapter::#{analyser_name}").new(@analysed_files).smells
      end
      ComplexityAdapter::Flog.new(@analysed_files).complexity
      Analyser::Churn.new(@analysed_files, @source_control_system).churn
    end
  end

end
