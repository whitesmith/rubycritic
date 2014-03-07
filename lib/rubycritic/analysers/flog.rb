require "flog"

module Rubycritic
  module Analyser

    class Flog < ::Flog
      DEFAULT_OPTIONS = {
        :all => true,
        :continue => true,
        :methods => true
      }

      def initialize(paths)
        super(DEFAULT_OPTIONS)
        flog(paths)
      end
    end

  end
end
