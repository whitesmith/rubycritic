# frozen_string_literal: true

module RubyCritic
  class Rating
    def self.from_cost(cost)
      if    cost <= 2  then new('A')
      elsif cost <= 4  then new('B')
      elsif cost <= 8  then new('C')
      elsif cost <= 16 then new('D')
      else new('F')
      end
    end

    def initialize(letter)
      @letter = letter
    end

    def to_s
      @letter
    end

    def to_h
      @letter
    end

    def to_json(*options)
      to_h.to_json(*options)
    end
  end
end
