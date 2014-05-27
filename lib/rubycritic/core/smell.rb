require "virtus"
require "rubycritic/core/location"

module Rubycritic

  class Smell
    include Virtus.model

    attribute :context
    attribute :cost
    attribute :locations
    attribute :message
    attribute :score
    attribute :status
    attribute :type

    def at_location?(other_location)
      locations.any? { |location| location == other_location }
    end

    def has_multiple_locations?
      locations.length > 1
    end

    def ==(other)
      state == other.state
    end
    alias_method :eql?, :==

    def to_s
      "(#{type}) #{context} #{message}"
    end

    def hash
      state.hash
    end

    protected

    def state
      [@context, @message, @score, @type]
    end
  end

end
