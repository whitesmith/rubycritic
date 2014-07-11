require "analysers_test_helper"
require "rubycritic/analysers/stats"

describe Rubycritic::Analyser::Stats do
  context "when a file contains Ruby code" do
    it "calculates the number of methods of each file and adds it to analysed_files" do
      analysed_file = AnalysedFileDouble.new(:path => "test/samples/stats/example.rb")
      Rubycritic::Analyser::Stats.new([analysed_file]).run
      analysed_file.methods_count.must_equal 2
    end
  end

  context "when a file is empty" do
    it "calculates the number of methods as 0, adding it to analysed_files" do
      analysed_file = AnalysedFileDouble.new(:path => "test/samples/stats/empty_example.rb")
      Rubycritic::Analyser::Stats.new([analysed_file]).run
      analysed_file.methods_count.must_equal 0
    end
  end
end
