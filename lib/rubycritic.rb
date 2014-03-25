require "rubycritic/source_locator"
require "rubycritic/analysers_runner"
require "rubycritic/smells_aggregator"
require "rubycritic/report_generators/reporter"

module Rubycritic

  class Rubycritic
    def initialize(dirs)
      @source = SourceLocator.new(dirs)
    end

    def critique
      smell_adapters = AnalysersRunner.new(@source.paths).run
      smelly_pathnames = SmellsAggregator.new(smell_adapters).smelly_pathnames
      Reporter.new(@source.pathnames, smelly_pathnames).generate_report
    end
  end

end
