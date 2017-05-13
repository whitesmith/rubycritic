# frozen_string_literal: true

require 'analysers_test_helper'
require 'rubycritic/analysers/complexity'

describe RubyCritic::Analyser::Complexity do
  context 'when analysing a file' do
    before do
      @analysed_module = AnalysedModuleDouble.new(path: 'test/samples/flog/complex.rb', smells: [])
      analysed_modules = [@analysed_module]
      RubyCritic::Analyser::Complexity.new(analysed_modules).run
    end

    it 'calculates its complexity' do
      @analysed_module.complexity.must_be :>, 0
    end
  end
end
