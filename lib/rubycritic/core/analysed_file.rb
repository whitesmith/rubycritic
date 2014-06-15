require "virtus"
require "rubycritic/core/rating"

module Rubycritic

  class AnalysedFile
    include Virtus.model

    attribute :pathname
    attribute :smells
    attribute :churn
    attribute :committed_at
    attribute :complexity
    attribute :methods_count

    def name
      @name ||= pathname.basename.sub_ext("").to_s
    end

    def path
      @path ||= pathname.to_s
    end

    def cost
      @cost ||= smells.map(&:cost).inject(0, :+)
    end

    def rating
      @rating ||= Rating.from_cost(cost)
    end

    def complexity_per_method
      complexity.fdiv(methods_count).round(1)
    rescue ZeroDivisionError
      "N/A"
    end

    def has_smells?
      !smells.empty?
    end

    def smells_at_location(location)
      smells.select { |smell| smell.at_location?(location) }
    end
  end

end
