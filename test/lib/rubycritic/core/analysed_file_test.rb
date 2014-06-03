require "test_helper"
require "rubycritic/core/analysed_file"

describe Rubycritic::AnalysedFile do
  describe "attribute readers" do
    before do
      @pathname = Pathname.new("foo/bar.rb")
      @smells = []
      @churn = 1
      @complexity = 2
      @analysed_file = Rubycritic::AnalysedFile.new(
        :pathname   => @pathname,
        :smells     => @smells,
        :churn      => @churn,
        :complexity => @complexity
      )
    end

    it "has a pathname reader" do
      @analysed_file.pathname.must_equal @pathname
    end

    it "has a smells reader" do
      @analysed_file.smells.must_equal @smells
    end

    it "has a churn reader" do
      @analysed_file.churn.must_equal @churn
    end

    it "has a complexity reader" do
      @analysed_file.complexity.must_equal @complexity
    end

    it "has a name reader" do
      @analysed_file.name.must_equal "bar"
    end

    it "has a path reader" do
      @analysed_file.path.must_equal @pathname.to_s
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
