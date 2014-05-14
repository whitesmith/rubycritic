require "test_helper"
require "rubycritic/analysed_file"

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
end
