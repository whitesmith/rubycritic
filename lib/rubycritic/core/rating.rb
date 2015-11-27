module Rubycritic

  class Rating
    def self.from_cost(cost)
      if    cost <= 2  then new("A")
      elsif cost <= 4  then new("B")
      elsif cost <= 8  then new("C")
      elsif cost <= 16 then new("D")
      else new("F")
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

    def to_json(*a)
      to_h.to_json(*a)
    end

    def to_gpa
      if @letter == "A" then 4.0
      elsif @letter == "B" then 3.0
      elsif @letter == "C" then 2.0
      elsif @letter == "D" then 1.0
      elsif @letter == "F" then 0.0
      else
        raise "unknown GPA"
      end
    end
  end

end
