# frozen_string_literal: true

module RubyCritic
  class AnalysisSummary
    def self.generate(analysed_modules)
      new(analysed_modules).generate
    end

    def initialize(analysed_modules)
      @analysed_modules = analysed_modules
    end

    def generate
      %w[A B C D F].each_with_object({}) do |rating, summary|
        summary[rating] = generate_for(rating)
      end
    end

    private

    attr_reader :analysed_modules, :modules

    def generate_for(rating)
      @modules = analysed_modules.for_rating(rating)
      {
        files: modules.count,
        churns: churns,
        smells: smells
      }
    end

    def churns
      modules.inject(0) { |acc, elem| acc + elem.churn }
    end

    def smells
      modules.inject(0) { |acc, elem| acc + elem.smells.count }
    end
  end
end
