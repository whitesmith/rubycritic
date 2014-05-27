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

    def has_smells?
      !smells.empty?
    end
  end

end
