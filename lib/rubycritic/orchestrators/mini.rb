require "rubycritic/orchestrators/base"
require "rubycritic/reporters/mini"

module Rubycritic
  module Orchestrator

    class Mini < Base
      def generate_report
        Reporter::Mini.new(@analysed_files).generate_report
      end
    end

  end
end
