require "flog"

module Rubycritic

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
