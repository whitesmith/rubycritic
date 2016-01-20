require "rubycritic/commands/base"

module Rubycritic
  module Command
    class Help < Base
      def execute
        puts @options[:help_text]
        @status_reporter
      end
    end
  end
end
