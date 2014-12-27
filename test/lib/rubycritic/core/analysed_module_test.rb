require "test_helper"
require "rubycritic/core/analysed_module"
require "rubycritic/core/smell"

describe Rubycritic::AnalysedModule do
  describe "attribute readers" do
    before do
      @name = "Foo"
      @pathname = Pathname.new("foo.rb")
      @smells = []
      @churn = 1
      @complexity = 2
      @analysed_module = Rubycritic::AnalysedModule.new(
        :name       => @name,
        :pathname   => @pathname,
        :smells     => @smells,
        :churn      => @churn,
        :complexity => @complexity
      )
    end

    it "has a name reader" do
      @analysed_module.name.must_equal @name
    end

    it "has a pathname reader" do
      @analysed_module.pathname.must_equal @pathname
    end

    it "has a path reader" do
      @analysed_module.path.must_equal @pathname.to_s
    end

    it "has a smells reader" do
      @analysed_module.smells.must_equal @smells
    end

    it "has a churn reader" do
      @analysed_module.churn.must_equal @churn
    end

    it "has a complexity reader" do
      @analysed_module.complexity.must_equal @complexity
    end
  end

  describe "#cost" do
    it "returns the remediation cost of fixing the analysed_module" do
      smells = [SmellDouble.new(:cost => 1), SmellDouble.new(:cost => 2)]
      analysed_module = Rubycritic::AnalysedModule.new(:smells => smells, :complexity => 0)
      analysed_module.cost.must_equal 3
    end
  end

  describe "#complexity_per_method" do
    context "when the file has no methods" do
      it "returns a placeholder" do
        analysed_module = Rubycritic::AnalysedModule.new(:complexity => 0, :methods_count => 0)
        analysed_module.complexity_per_method.must_equal "N/A"
      end
    end

    context "when the file has at least one method" do
      it "returns the average complexity per method" do
        analysed_module = Rubycritic::AnalysedModule.new(:complexity => 10, :methods_count => 2)
        analysed_module.complexity_per_method.must_equal 5
      end
    end
  end

  describe "#smells?" do
    it "returns true if the analysed_module has at least one smell" do
      analysed_module = Rubycritic::AnalysedModule.new(:smells => [SmellDouble.new])
      analysed_module.smells?.must_equal true
    end
  end

  describe "#smells_at_location" do
    it "returns the smells of an analysed_module at a certain location" do
      location = Rubycritic::Location.new("./foo", "42")
      smells = [Rubycritic::Smell.new(:locations => [location])]
      analysed_module = Rubycritic::AnalysedModule.new(:smells => smells)
      analysed_module.smells_at_location(location).must_equal smells
    end
  end
end

class SmellDouble < OpenStruct; end
