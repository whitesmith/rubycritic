require "test_helper"
require "rubycritic/analysers/flay"
require "rubycritic/smell_adapters/flay"

describe Rubycritic::SmellAdapter::Flay do
  before do
    sample_paths = ["test/samples/flay/smelly.rb"]
    flay = Rubycritic::Analyser::Flay.new(sample_paths)
    @adapter = Rubycritic::SmellAdapter::Flay.new(flay)
  end

  it "detects smells" do
    @adapter.smells.wont_be_empty
  end

  it "has smells with messages" do
    smell = @adapter.smells.first
    smell.message.must_equal "found in 2 nodes"
  end

  it "has smells with messages" do
    smell = @adapter.smells.first
    smell.score.must_be_kind_of Numeric
  end
end
