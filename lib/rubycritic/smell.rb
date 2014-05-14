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
    attribute :status

    def at_pathname?(other_pathname)
      pathnames.any? { |pathname| pathname == other_pathname }
    end

    def at_location?(other_location)
      locations.any? { |location| location == other_location }
    end

    def has_multiple_locations?
      locations.length > 1
    end

    def ==(other)
      self.class == other.class && state == other.state
    end
    alias_method :eql?, :==

    def <=>(other)
      locations <=> other.locations
    end

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

    private

    def pathnames
      @pathnames ||= locations.map(&:pathname).uniq
    end
  end

end
