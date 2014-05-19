require "rubycritic/active_support/methods"
require "rubycritic/adapters/smell/flay"
require "rubycritic/adapters/smell/flog"
require "rubycritic/adapters/smell/reek"

module Rubycritic

  class AnalysersRunner
    include ActiveSupport

    ANALYSERS = ["Flay", "Flog", "Reek"]

    def initialize(paths)
      @paths = paths
    end

    def smells
      aggregate_smells(smell_adapters)
    end

    private

    def smell_adapters
      ANALYSERS.map do |analyser_name|
        constantize("Rubycritic::SmellAdapter::#{analyser_name}").new(@paths)
      end
    end

    def aggregate_smells(smell_adapters)
      smell_adapters.flat_map(&:smells)
    end
  end

end
