require "rubycritic/active_support/methods"
require "rubycritic/analysers/flay"
require "rubycritic/analysers/flog"
require "rubycritic/analysers/reek"
require "rubycritic/smell_adapters/flay"
require "rubycritic/smell_adapters/flog"
require "rubycritic/smell_adapters/reek"

module Rubycritic

  class AnalysersRunner
    include ActiveSupport

    ANALYSERS = ["Flay", "Flog", "Reek"]

    def initialize(paths)
      @paths = paths
    end

    def run
      aggregate_smells(smell_adapters)
    end

    private

    def smell_adapters
      ANALYSERS.map do |analyser_name|
        analyser = constantize("Rubycritic::Analyser::#{analyser_name}").new(@paths)
        constantize("Rubycritic::SmellAdapter::#{analyser_name}").new(analyser)
      end
    end

    def aggregate_smells(smell_adapters)
      smell_adapters.map(&:smells).flatten.sort
    end
  end

end
