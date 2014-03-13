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
      @paths ||= locations.map(&:path).uniq
    end

    def <=>(other)
      locations <=> other.locations
    end
  end

end
