require "pathname"

module Rubycritic

  class Location
    attr_reader :pathname, :line

    def initialize(path, line)
      @pathname = Pathname.new(path)
      @line = line
    end

    def to_s
      "#{pathname}:#{line}"
    end

    def ==(other)
      self.class == other.class && state == other.state
    end

    def <=>(other)
      state <=> other.state
    end

    protected

    def state
      [@pathname, @line]
    end
  end

end
