module Rubycritic
  module Analyser

    class Churn
      def initialize(paths, source_control_system)
        @paths = paths
        @source_control_system = source_control_system
      end

      def churn
        @paths.map { |path| @source_control_system.revisions_count(path) }
      end
    end

  end
end
