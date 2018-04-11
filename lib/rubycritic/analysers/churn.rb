# frozen_string_literal: true

require 'rubycritic/colorize'

module RubyCritic
  module Analyser
    class Churn
      include Colorize
      attr_writer :source_control_system

      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
        @source_control_system = Config.source_control_system
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.churn = @source_control_system.revisions_count(analysed_module.path)
          analysed_module.committed_at = @source_control_system.date_of_last_commit(analysed_module.path)
          print green '.'
        end
        puts ''
      end

      def to_s
        'churn'
      end
    end
  end
end
