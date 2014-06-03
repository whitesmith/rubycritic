require "rubycritic/orchestrators/base"
require "rubycritic/reporters/main"

module Rubycritic
  module Orchestrator

    class Main < Base
      def generate_report
        Reporter::Main.new(@analysed_files).generate_report
      end
    end

  end
end
