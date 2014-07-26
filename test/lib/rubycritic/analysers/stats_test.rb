require "analysers_test_helper"
require "rubycritic/analysers/stats"

describe Rubycritic::Analyser::Stats do
  context "when a file contains Ruby code" do
    it "calculates the number of methods of each file and adds it to analysed_modules" do
      analysed_module = AnalysedModuleDouble.new(:path => "test/samples/stats/example.rb")
      Rubycritic::Analyser::Stats.new([analysed_module]).run
      analysed_module.methods_count.must_equal 2
    end
  end

  context "when a file is empty" do
    it "calculates the number of methods as 0, adding it to analysed_modules" do
      analysed_module = AnalysedModuleDouble.new(:path => "test/samples/stats/empty_example.rb")
      Rubycritic::Analyser::Stats.new([analysed_module]).run
      analysed_module.methods_count.must_equal 0
    end
  end

  context "when a file is unparsable" do
    it "does not blow up" do
      analysed_module = AnalysedModuleDouble.new(:path => "test/samples/stats/unparsable_example.rb")
      capture_output_streams do
        Rubycritic::Analyser::Stats.new([analysed_module]).run
      end
      analysed_module.methods_count.must_equal 0
    end
  end
end
