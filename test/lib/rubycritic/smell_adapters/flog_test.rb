require "test_helper"
require "rubycritic/smell_adapters/flog"

describe Rubycritic::SmellAdapter::Flog do
  before do
    sample_paths = ["test/samples/flog/smelly.rb"]
    @adapter = Rubycritic::SmellAdapter::Flog.new(sample_paths)
  end

  it "detects smells" do
    @adapter.smells.wont_be_empty
  end

  it "has smells with messages" do
    smell = @adapter.smells.first
    smell.message.must_be_instance_of String
  end

  it "has smells with scores" do
    smell = @adapter.smells.first
    smell.score.must_be_kind_of Numeric
  end
end
