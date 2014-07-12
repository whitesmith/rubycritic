require "analysers_test_helper"
require "rubycritic/analysers/complexity"

describe Rubycritic::Analyser::Complexity do
  it "calculates the complexity of each file and adds it to analysed_files" do
    analysed_files = [AnalysedFileDouble.new(:path => "test/samples/flog/complex.rb")]
    Rubycritic::Analyser::Complexity.new(analysed_files).run
    analysed_files.each do |analysed_file|
      analysed_file.complexity.must_be_kind_of Numeric
    end
  end
end
