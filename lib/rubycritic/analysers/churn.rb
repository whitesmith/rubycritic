module Rubycritic
  module Analyser

    class Churn
      def initialize(analysed_files, source_control_system)
        @analysed_files = analysed_files
        @source_control_system = source_control_system
      end

      def run
        @analysed_files.each do |analysed_file|
          analysed_file.churn = @source_control_system.revisions_count(analysed_file.path)
          analysed_file.committed_at = @source_control_system.date_of_last_commit(analysed_file.path)
        end
      end
    end

  end
end
