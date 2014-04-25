require "flay"

module Rubycritic
  module Analyser

    class Flay < ::Flay
      def initialize(paths)
        super()
        process(*paths)
        analyze
      end
    end

  end
end
