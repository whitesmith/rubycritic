# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/analysis_summary'

module RubyCritic
  describe AnalysisSummary do
    before do
      analysed_modules = AnalysedModulesCollectionDouble.new(
        [
          AnalysedModuleDouble.new(rating: 'A', churn: 2, smells: %i[a b c]),
          AnalysedModuleDouble.new(rating: 'A', churn: 3, smells: [:b]),
          AnalysedModuleDouble.new(rating: 'A', churn: 4, smells: %i[x y]),
          AnalysedModuleDouble.new(rating: 'B', churn: 5, smells: %i[a z])
        ]
      )
      @summary = RubyCritic::AnalysisSummary.generate(analysed_modules)
    end

    describe '.root' do
      it 'computes correct summary' do
        @summary['A'].to_a.must_equal({ files: 3, churns: 9, smells: 6 }.to_a)
        @summary['B'].to_a.must_equal({ files: 1, churns: 5, smells: 2 }.to_a)
        @summary['C'].to_a.must_equal({ files: 0, churns: 0, smells: 0 }.to_a)
        @summary['D'].to_a.must_equal({ files: 0, churns: 0, smells: 0 }.to_a)
        @summary['F'].to_a.must_equal({ files: 0, churns: 0, smells: 0 }.to_a)
      end
    end
  end
end
