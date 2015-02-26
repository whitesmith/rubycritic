require "analysers_test_helper"
require "rubycritic/analysers/complexity"

describe Rubycritic::Analyser::Complexity do
  context "when analysing a file" do
    before do
      @analysed_module = AnalysedModuleDouble.new(:path => "test/samples/flog/complex.rb", :smells => [])
      analysed_modules = [@analysed_module]
      Rubycritic::Analyser::Complexity.new(analysed_modules).run
    end

    it "calculates its complexity" do
      @analysed_module.complexity.must_be :>, 0
    end
  end
end
