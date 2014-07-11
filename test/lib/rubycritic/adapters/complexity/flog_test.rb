require "test_helper"
require "rubycritic/analysers/flog"
require "rubycritic/adapters/complexity/flog"

describe Rubycritic::ComplexityAdapter::Flog do
  before do
    @analysed_files = [AnalysedFileDouble.new(:path => "test/samples/flog/complex.rb")]
    Rubycritic::ComplexityAdapter::Flog.new(@analysed_files).run
  end

  it "calculates the complexity of each file and adds it to analysed_files" do
    @analysed_files.each do |analysed_file|
      analysed_file.complexity.must_be_kind_of Numeric
    end
  end
end

class AnalysedFileDouble < OpenStruct; end
