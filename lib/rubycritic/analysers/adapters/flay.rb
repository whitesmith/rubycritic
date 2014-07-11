require "flay"

module Rubycritic

  class Flay < ::Flay
    def initialize(paths)
      super()
      process(*paths)
      analyze
    end
  end

end
