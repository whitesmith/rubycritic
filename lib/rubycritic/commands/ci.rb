# frozen_string_literal: true

require 'rubycritic/source_control_systems/base'
require 'rubycritic/analysers_runner'
require 'rubycritic/reporter'
require 'rubycritic/commands/default'

module RubyCritic
  module Command
    class Ci < Default
      def critique
        AnalysersRunner.new(paths).run
      end

      private

      attr_reader :paths
    end
  end
end
