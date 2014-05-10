require "test_helper"
require "rubycritic/analysers/flog"
require "rubycritic/quality_adapters/flog"

describe Rubycritic::QualityAdapter::Flog do
  before do
    sample_paths = ["test/samples/flog/smelly.rb", "test/samples/flog/smelly2.rb"]
    @adapter = Rubycritic::QualityAdapter::Flog.new(sample_paths)
  end

  describe "#complexity" do
    it "return an array containing the complexity of each file" do
      @adapter.complexity.each do |file_complexity|
        file_complexity.must_be_kind_of Numeric
      end
    end
  end
end
