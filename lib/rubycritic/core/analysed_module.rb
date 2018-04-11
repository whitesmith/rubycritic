# frozen_string_literal: true

require 'virtus'
require 'rubycritic/core/rating'

module RubyCritic
  class AnalysedModule
    include Virtus.model

    # Complexity is reduced by a factor of 25 when calculating cost
    COMPLEXITY_FACTOR = 25.0

    attribute :name
    attribute :smells_count
    attribute :file_location
    attribute :file_name
    attribute :line_count
    attribute :pathname
    attribute :smells, Array, default: []
    attribute :churn
    attribute :committed_at
    attribute :complexity, Float, default: Float::INFINITY
    attribute :duplication, Integer, default: 0
    attribute :methods_count

    def path
      @path ||= pathname.to_s
    end

    def file_location
      pathname.dirname
    end

    def file_name
      pathname.basename
    end

    def line_count
      File.read(path).each_line.count
    end

    def cost
      @cost ||= smells.map(&:cost).inject(0.0, :+) +
                (complexity / COMPLEXITY_FACTOR)
    end

    def rating
      @rating ||= Rating.from_cost(cost)
    end

    def complexity_per_method
      if methods_count.zero?
        'N/A'
      else
        complexity.fdiv(methods_count).round(1)
      end
    end

    def smells_count
      smells.count
    end

    def smells?
      !smells.empty?
    end

    def smells_at_location(location)
      smells.select { |smell| smell.at_location?(location) }
    end

    def <=>(other)
      [rating.to_s, name] <=> [other.rating.to_s, other.name]
    end

    def to_h
      {
        name: name,
        path: path,
        smells: smells,
        churn: churn,
        committed_at: committed_at,
        complexity: complexity,
        duplication: duplication,
        methods_count: methods_count,
        cost: cost,
        rating: rating
      }
    end

    def to_json(*options)
      to_h.to_json(*options)
    end
  end
end
