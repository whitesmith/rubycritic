require "rubycritic/source_locator"
require "rubycritic/analysers/reek"
require "rubycritic/smell_adapters/reek"
require "rubycritic/smells_aggregator"
require "rubycritic/report_generators/reporter"

module Rubycritic

  class Rubycritic
    def initialize(paths)
      @source = SourceLocator.new(paths)

      analyser = Analyser::Reek.new(@source.paths)
      smell_adapters = [ SmellAdapter::Reek.new(analyser) ]
      @aggregator = SmellsAggregator.new(smell_adapters)
    end

    def critique
      Reporter.new(@source.pathnames, @aggregator.smelly_pathnames).generate_report
    end
  end

end
