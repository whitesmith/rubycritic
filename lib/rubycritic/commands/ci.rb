require "rubycritic/source_control_systems/base"
require "rubycritic/analysers_runner"
require "rubycritic/reporter"
require "rubycritic/commands/default"

module Rubycritic
  module Command
    class Ci < Default
      def critique
        AnalysersRunner.new(@paths).run
      end
    end
  end
end
