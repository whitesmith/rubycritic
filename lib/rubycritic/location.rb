require "pathname"

module Rubycritic

  class Location
    attr_reader :line

    def initialize(path, line)
      @pathname = Pathname.new(path)
      @line = line
    end

    def path
      @pathname.to_s
    end

    def file
      @pathname.basename.to_s
    end

    def to_s
      "#{path}:#{line}"
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
