require "rubycritic"
require "rubycritic/cli/options"

module Rubycritic
  module Cli
    class Application
      STATUS_SUCCESS = 0
      STATUS_ERROR   = 1

      def initialize(argv)
        @options = Options.new(argv)
      end

      def execute
        parsed_options = @options.parse
        ::Rubycritic.create(parsed_options).execute
        STATUS_SUCCESS
      rescue OptionParser::InvalidOption => error
        $stderr.puts "Error: #{error}"
        STATUS_ERROR
      end
    end
  end
end
