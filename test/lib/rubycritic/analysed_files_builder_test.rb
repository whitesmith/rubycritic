require "test_helper"
require "rubycritic/analysed_files_builder"

describe Rubycritic::AnalysedFilesBuilder do
  describe "analysed_files" do
    before do
      @pathnames = [Pathname.new("./foo"), Pathname.new("./bar")]
      @smells = [SmellDouble.new]
      @churn = [1, 2]
      @complexity = [3, 4]
      @builder = Rubycritic::AnalysedFilesBuilder.new(@pathnames, @smells, @churn, @complexity)
    end

    it "returns an array of AnalysedFiles" do
      analysed_files = @builder.analysed_files
      first = analysed_files.first
      last = analysed_files.last

      first.pathname.must_equal Pathname.new("./foo")
      first.smells.must_equal @smells
      first.churn.must_equal @churn.first
      first.complexity.must_equal @complexity.first

      last.pathname.must_equal Pathname.new("./bar")
      last.smells.must_equal @smells
      last.churn.must_equal @churn.last
      last.complexity.must_equal @complexity.last
    end
  end
end

class SmellDouble
  def at_pathname?(other_pathname)
    true
  end
end
