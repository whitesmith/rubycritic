require "test_helper"
require "rubycritic/smells_aggregator"

describe Rubycritic::SmellsAggregator do
  context "when analysing smelly files" do
    before do
      @location1 = Rubycritic::Location.new("./foo", "42")
      @location2 = Rubycritic::Location.new("./bar", "23")
      @location3 = Rubycritic::Location.new("./bar", "16")
      @smell1 = Rubycritic::Smell.new(:locations => [@location1])
      @smell2 = Rubycritic::Smell.new(:locations => [@location2, @location3])
      @smell_adapters = [stub(:smells => [@smell1]), stub(:smells => [@smell2])]
    end

    describe "#smells" do
      it "returns the smells found in those files" do
        smells = [@smell2, @smell1]
        Rubycritic::SmellsAggregator.new(@smell_adapters).smells.must_equal smells
      end
    end

    describe "#smelly_pathnames" do
      it "returns the files where smells were found" do
        smelly_pathnames = {@location1.pathname => [@smell1], @location2.pathname => [@smell2]}
        Rubycritic::SmellsAggregator.new(@smell_adapters).smelly_pathnames.must_equal smelly_pathnames
      end
    end
  end

  context "when analysing files with no smells" do
    before do
      @smell_adapters = [stub(:smells => [])]
    end

    describe "#smells" do
      it "returns an empty array" do
        Rubycritic::SmellsAggregator.new(@smell_adapters).smells.must_equal []
      end
    end

    describe "#smelly_pathnames" do
      it "returns an empty hash" do
        Rubycritic::SmellsAggregator.new(@smell_adapters).smelly_pathnames.must_equal({})
      end
    end
  end
end
