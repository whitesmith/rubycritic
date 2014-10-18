module Rubycritic
  module Command
    class Help
      def initialize(options)
        @options = options
      end

      def execute
        puts @options.help_text
      end
    end
  end
end
