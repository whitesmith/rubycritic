require "rubycritic/analysers/smells/flay"
require "rubycritic/analysers/smells/flog"
require "rubycritic/analysers/smells/reek"
require "rubycritic/analysers/complexity"
require "rubycritic/analysers/churn"
require "rubycritic/analysers/stats"

module Rubycritic

  class AnalysersRunner
    ANALYSERS = [
      Analyser::FlaySmells,
      Analyser::FlogSmells,
      Analyser::ReekSmells,
      Analyser::Complexity,
      Analyser::Stats
    ]

    def initialize(analysed_modules, source_control_system)
      @analysed_modules = analysed_modules
      @source_control_system = source_control_system
    end

    def run
      ANALYSERS.each do |analyser|
        analyser.new(@analysed_modules).run
      end
      Analyser::Churn.new(@analysed_modules, @source_control_system).run
    end
  end

end
