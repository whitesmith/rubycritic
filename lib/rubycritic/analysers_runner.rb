require "rubycritic/modules_initializer"
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
      Analyser::Attributes
    ]

    def initialize(paths, source_control_system)
      @paths = paths
      @source_control_system = source_control_system
    end

    def run
      analysed_modules = ModulesInitializer.init(@paths)

      ANALYSERS.each { |analyser| analyser.new(analysed_modules).run }
      Analyser::Churn.new(analysed_modules, @source_control_system).run

      analysed_modules
    end
  end

end
