require "rubycritic/source_control_systems/base"
require "rubycritic/analysers_runner"
require "rubycritic/reporters/main"

module Rubycritic
  module Command
    class Ci
      def initialize(options)
        @paths = options[:paths]
        Config.source_control_system = SourceControlSystem::Base.create
      end

      def execute
        critique(@paths)
        report
      end

      def critique(paths)
        @analysed_modules = AnalysersRunner.new(paths).run
      end

      def report
        report_location = Reporter::Main.new(@analysed_modules).generate_report
        puts "New critique at #{report_location}"
      end
    end
  end
end
