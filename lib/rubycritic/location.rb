require "pathname"

module Rubycritic

  class Location
    attr_reader :line

    def initialize(path, line)
      @path = Pathname.new(path)
      @line = line
    end

    def path
      @path.to_s
    end

    def file
      @path.basename.to_s
    end

    def to_s
      "#{path}:#{line}"
    end

    def <=>(other)
      state <=> other.state
    end

    protected

    def state
      [@path, @line]
    end
  end

end
