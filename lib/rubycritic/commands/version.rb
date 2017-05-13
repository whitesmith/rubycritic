# frozen_string_literal: true

require 'rubycritic/version'
require 'rubycritic/commands/base'

module RubyCritic
  module Command
    class Version < Base
      attr_reader :status_reporter
      def execute
        puts "RubyCritic #{VERSION}"
        status_reporter
      end
    end
  end
end
