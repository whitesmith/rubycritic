require "rubycritic/version"
require "rubycritic/commands/base"

module Rubycritic
  module Command
    class Version < Base
      def execute
        puts "RubyCritic #{VERSION}"
        @status_reporter
      end
    end
  end
end
