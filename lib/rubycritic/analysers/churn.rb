# frozen_string_literal: true

module RubyCritic
  module Analyser
    class Churn
      attr_writer :source_control_system

      def initialize(analysed_modules, logger=nil)
        @analysed_modules = analysed_modules
        @logger = logger
        @source_control_system = Config.source_control_system
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.churn = @source_control_system.revisions_count(analysed_module.path)
          analysed_module.committed_at = @source_control_system.date_of_last_commit(analysed_module.path)

          @logger.report_completion unless @logger.nil?
        end
      end

      def to_s
        'churn'
      end
    end
  end
end
