require "test_helper"
require "rubycritic/analysers_runner"

describe Rubycritic::AnalysersRunner do
  describe "#smells" do
    it "returns the smells found by various analysers" do
      smells = Rubycritic::AnalysersRunner.new("test/samples/analysers_runner/empty.rb").smells
      smells.must_be_instance_of Array
    end
  end
end
