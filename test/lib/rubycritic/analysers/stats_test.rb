require "test_helper"
require "rubycritic/analysers/stats"

describe Rubycritic::Analyser::Stats do
  before do
    @analysed_files = [AnalysedFileDouble.new(:path => "test/samples/stats/example.rb")]
  end

  it "calculates the number of methods of each file and adds it to analysed_files" do
    Rubycritic::Analyser::Stats.new(@analysed_files).stats
    @analysed_files.each do |analysed_file|
      analysed_file.methods_count.must_equal 2
    end
  end
end
