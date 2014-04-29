require "test_helper"
require "rubycritic/smells_aggregator"

describe Rubycritic::SmellsAggregator do
  context "when analysing smelly files" do
    before do
      smell1 = Rubycritic::Smell.new
      smell2 = Rubycritic::Smell.new
      @smells = [smell2, smell1]
      @smell_adapters = [stub(:smells => [smell1]), stub(:smells => [smell2])]
    end

    describe "#smells" do
      it "returns the smells found in those files" do
        Rubycritic::SmellsAggregator.new(@smell_adapters).smells.must_equal @smells
      end
    end
  end

  context "when analysing files with no smells" do
    before do
      @smells = []
      @smell_adapters = [stub(:smells => @smells)]
    end

    describe "#smells" do
      it "returns an empty array" do
        Rubycritic::SmellsAggregator.new(@smell_adapters).smells.must_equal @smells
      end
    end
  end
end
