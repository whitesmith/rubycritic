require "test_helper"
require "rubycritic/adapters/smell/flay"

describe Rubycritic::SmellAdapter::Flay do
  before do
    sample_paths = ["test/samples/flay/smelly.rb"]
    @adapter = Rubycritic::SmellAdapter::Flay.new(sample_paths)
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
