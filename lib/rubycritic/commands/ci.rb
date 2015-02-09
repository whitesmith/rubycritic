require "rubycritic/source_control_systems/base"
require "rubycritic/analysers_runner"
require "rubycritic/reporters/main"

module Rubycritic
  module Command
    class Ci
      def initialize(paths)
        @paths = paths
        Config.source_control_system = SourceControlSystem::Base.create
      end

      def execute
        report(critique)
      end

      def critique
        AnalysersRunner.new(@paths).run
      end

      def report(analysed_modules)
        report_location = Reporter::Main.new(analysed_modules).generate_report
        puts "New critique at #{report_location}"
      end
    end
  end
end
