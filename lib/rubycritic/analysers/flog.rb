require "flog"

module Rubycritic
  module Analyser

    class Flog < ::Flog
      DEFAULT_OPTIONS = {
        :all => true,
        :continue => true,
        :methods => true
      }

      def initialize
        super(DEFAULT_OPTIONS)
      end
    end

  end
end
