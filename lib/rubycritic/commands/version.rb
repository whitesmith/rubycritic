require "rubycritic/version"

module Rubycritic
  module Command
    class Version
      def execute
        puts "RubyCritic #{VERSION}"
      end
    end
  end
end
