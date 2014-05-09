require "rubycritic/active_support/methods"
require "rubycritic/analysers/flay"
require "rubycritic/analysers/flog"
require "rubycritic/analysers/reek"
require "rubycritic/smell_adapters/flay"
require "rubycritic/smell_adapters/flog"
require "rubycritic/smell_adapters/reek"
require "rubycritic/smells_aggregator"

module Rubycritic

  class AnalysersRunner
    include ActiveSupport

    ANALYSERS = ["Flay", "Flog", "Reek"]

    def initialize(paths)
      @paths = paths
    end

    def run
      SmellsAggregator.new(smell_adapters).smells
    end

    private

    def smell_adapters
      ANALYSERS.map do |analyser_name|
        analyser = constantize("Rubycritic::Analyser::#{analyser_name}").new(@paths)
        constantize("Rubycritic::SmellAdapter::#{analyser_name}").new(analyser)
      end
    end
  end

end
