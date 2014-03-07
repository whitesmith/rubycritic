require "virtus"
require "rubycritic/location"

module Rubycritic

  class Smell
    include Virtus.model

    attribute :context
    attribute :location
    attribute :metric
    attribute :score
  end

end
