module Rubycritic
  module Command
    class Help
      def initialize(help_text)
        @help_text = help_text
      end

      def execute
        puts @help_text
      end
    end
  end
end
