# frozen_string_literal: true

require 'rubycritic/commands/base'

module RubyCritic
  module Command
    class Help < Base
      def execute
        puts options[:help_text]
        status_reporter
      end

      private

      attr_reader :options, :status_reporter
    end
  end
end
