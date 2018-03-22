# frozen_string_literal: true

require 'pathname'

module RubyCritic
  class Location
    attr_reader :pathname, :line

    def initialize(path, line)
      @pathname = Pathname.new(path)
      @line = line.to_i
    end

    def file_name
      @pathname.basename.sub_ext('').to_s
    end

    def to_s
      "#{pathname}:#{line}"
    end

    def to_h
      {
        path: pathname.to_s,
        line: line
      }
    end

    def to_json(*options)
      to_h.to_json(*options)
    end

    def ==(other)
      state == other.state
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
