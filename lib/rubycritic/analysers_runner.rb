require "rubycritic/active_support/methods"
require "rubycritic/analysers/flay"
require "rubycritic/smell_adapters/flay"
require "rubycritic/analysers/reek"
require "rubycritic/smell_adapters/reek"

module Rubycritic

  class AnalysersRunner
    include ActiveSupport

    ANALYSERS = ["Flay", "Reek"]

    def initialize(paths)
      @paths = paths
    end

    def run
      run_analysers_and_instantiate_adapters
    end

    private

    def run_analysers_and_instantiate_adapters
      ANALYSERS.map do |analyser_name|
        analyser = constantize("Rubycritic::Analyser::#{analyser_name}").new(@paths)
        constantize("Rubycritic::SmellAdapter::#{analyser_name}").new(analyser)
      end
    end
  end

end
