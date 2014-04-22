require "rubycritic/analysers/reek"
require "rubycritic/smell_adapters/reek"

module Rubycritic

  class AnalysersRunner
    ANALYSERS = ["Reek"]

    def initialize(paths)
      @paths = paths
    end

    def run
      run_analysers_and_instantiate_adapters
    end

    private

    def run_analysers_and_instantiate_adapters
      ANALYSERS.map do |analyser_name|
        analyser = Object.const_get("Rubycritic::Analyser::#{analyser_name}").new(@paths)
        Object.const_get("Rubycritic::SmellAdapter::#{analyser_name}").new(analyser)
      end
    end
  end

end
