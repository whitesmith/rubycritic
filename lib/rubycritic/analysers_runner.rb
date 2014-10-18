require "rubycritic/source_locator"
require "rubycritic/core/analysed_module"
require "rubycritic/analysers/smells/flay"
require "rubycritic/analysers/smells/flog"
require "rubycritic/analysers/smells/reek"
require "rubycritic/analysers/complexity"
require "rubycritic/analysers/churn"
require "rubycritic/analysers/attributes"

module Rubycritic

  class AnalysersRunner
    ANALYSERS = [
      Analyser::FlaySmells,
      Analyser::FlogSmells,
      Analyser::ReekSmells,
      Analyser::Complexity,
      Analyser::Attributes,
      Analyser::Churn
    ]

    def initialize(paths)
      @paths = paths
    end

    def run
      ANALYSERS.each { |analyser| analyser.new(analysed_modules).run }
      analysed_modules
    end

    def analysed_modules
      @analysed_modules ||= SourceLocator.new(@paths).pathnames.map do |pathname|
        AnalysedModule.new(:pathname => pathname)
      end
    end
  end

end
