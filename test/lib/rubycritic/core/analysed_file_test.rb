require "test_helper"
require "rubycritic/core/analysed_file"

describe Rubycritic::AnalysedFile do
  describe "attribute readers" do
    before do
      @pathname = Pathname.new("./foo")
      @smells = []
      @churn = 1
      @complexity = 2
      @smell = Rubycritic::AnalysedFile.new(
        :pathname   => @pathname,
        :smells     => @smells,
        :churn      => @churn,
        :complexity => @complexity
      )
    end

    it "has a pathname reader" do
      @smell.pathname.must_equal @pathname
    end

    it "has a smells reader" do
      @smell.smells.must_equal @smells
    end

    it "has a churn reader" do
      @smell.churn.must_equal @churn
    end

    it "has a complexity reader" do
      @smell.complexity.must_equal @complexity
    end
  end

  describe "#name" do
    it "returns the name of the file" do
      analysed_file = Rubycritic::AnalysedFile.new(:pathname => Pathname.new("foo/bar.rb"))
      analysed_file.name.must_equal "bar"
    end
  end

  describe "#has_smells?" do
    it "returns true if the analysed_file has at least one smell" do
      analysed_file = Rubycritic::AnalysedFile.new(:smells => [SmellDouble.new])
      analysed_file.has_smells?.must_equal true
    end
  end
end

class SmellDouble; end
