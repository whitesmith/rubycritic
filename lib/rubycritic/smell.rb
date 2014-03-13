require "virtus"
require "rubycritic/location"

module Rubycritic

  class Smell
    include Virtus.model

    attribute :context
    attribute :locations
    attribute :message
    attribute :score
    attribute :type

    def paths
      locations.map(&:path)
    end
  end

end
