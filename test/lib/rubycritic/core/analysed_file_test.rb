require "test_helper"
require "rubycritic/core/analysed_file"
require "rubycritic/core/smell"

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

  describe "#cost" do
    it "returns the remediation cost of fixing the analysed_file" do
      smells = [SmellDouble.new(:cost => 1), SmellDouble.new(:cost => 2)]
      analysed_file = Rubycritic::AnalysedFile.new(:smells => smells, :complexity => 0)
      analysed_file.cost.must_equal 3
    end
  end

  describe "#complexity_per_method" do
    context "when the file has no methods" do
      it "returns a placeholder" do
        analysed_file = Rubycritic::AnalysedFile.new(:complexity => 0, :methods_count => 0)
        analysed_file.complexity_per_method.must_equal "N/A"
      end
    end

    context "when the file has at least one method" do
      it "returns the average complexity per method" do
        analysed_file = Rubycritic::AnalysedFile.new(:complexity => 10, :methods_count => 2)
        analysed_file.complexity_per_method.must_equal 5
      end
    end
  end

  describe "#has_smells?" do
    it "returns true if the analysed_file has at least one smell" do
      analysed_file = Rubycritic::AnalysedFile.new(:smells => [SmellDouble.new])
      analysed_file.has_smells?.must_equal true
    end
  end

  describe "#smells_at_location" do
    it "returns the smells of an analysed_file at a certain location" do
      location = Rubycritic::Location.new("./foo", "42")
      smells = [Rubycritic::Smell.new(:locations => [location])]
      analysed_file = Rubycritic::AnalysedFile.new(:smells => smells)
      analysed_file.smells_at_location(location).must_equal smells
    end
  end
end

class SmellDouble < OpenStruct; end
