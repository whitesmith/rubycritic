require "analysers_test_helper"
require "rubycritic/analysers/complexity"

describe Rubycritic::Analyser::Complexity do
  it "calculates the complexity of each file and adds it to analysed_modules" do
    analysed_modules = [AnalysedModuleDouble.new(:path => "test/samples/flog/complex.rb")]
    Rubycritic::Analyser::Complexity.new(analysed_modules).run
    analysed_modules.each do |analysed_module|
      analysed_module.complexity.must_be_kind_of Numeric
    end
  end
end
