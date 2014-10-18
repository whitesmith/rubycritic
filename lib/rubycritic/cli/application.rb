require "rubycritic"
require "rubycritic/cli/options"

module Rubycritic
  module Cli
    class Application
      STATUS_SUCCESS = 0

      def initialize(argv)
        @options = Options.new(argv)
      end

      def execute
        parsed_options = @options.parse
        ::Rubycritic.create(parsed_options).execute
        STATUS_SUCCESS
      end
    end
  end
end
