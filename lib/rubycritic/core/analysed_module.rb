require "virtus"
require "rubycritic/core/rating"

module Rubycritic

  class AnalysedModule
    include Virtus.model

    attribute :name
    attribute :pathname
    attribute :smells,        Array,   :default => []
    attribute :churn
    attribute :committed_at
    attribute :complexity
    attribute :duplication,   Integer, :default => 0
    attribute :methods_count
    attribute :lines

    def path
      @path ||= pathname.to_s
    end

    def cost
      @cost ||= smells.map(&:cost).inject(0, :+) + (complexity / 25)
    end

    def rating
      @rating ||= Rating.from_cost(cost)
    end

    def lines
      return @lines if @lines
      count = 0
      File.open(path).each_line do |line|
        count += 1 unless line.strip[0] == "#" || line.strip.empty?
      end
      @lines = count
    end

    def complexity_per_method
      if methods_count == 0
        "N/A"
      else
        complexity.fdiv(methods_count).round(1)
      end
    end

    def smells?
      !smells.empty?
    end

    def smells_at_location(location)
      smells.select { |smell| smell.at_location?(location) }
    end

    def to_h
      {
        :name => name,
        :path => path,
        :smells => smells,
        :churn => churn,
        :committed_at => committed_at,
        :complexity => complexity,
        :duplication => duplication,
        :methods_count => methods_count,
        :cost => cost,
        :rating => rating
      }
    end

    def to_json(*a)
      to_h.to_json(*a)
    end
  end

end
