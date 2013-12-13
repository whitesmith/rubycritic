module Rubycritic

  class Location
    attr_reader :path, :line

    def initialize(path, line)
      @path = path
      @line = line
    end

    def to_s
      "#{path}:#{line}"
    end
  end

end
