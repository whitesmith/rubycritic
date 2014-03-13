require "test_helper"
require "rubycritic/analysers/flog"
require "rubycritic/smell_adapters/flog"

describe Rubycritic::SmellAdapter::Flog do
  before do
    @sample_path = "test/samples/flog/smelly.rb"
    flog = Rubycritic::Analyser::Flog.new([@sample_path])
    @adapter = Rubycritic::SmellAdapter::Flog.new(flog)
  end

  it "detects smells" do
    @adapter.smells.wont_be_empty
  end

  it "has smells with messages" do
    smell = @adapter.smells.first
    smell.message.must_equal "has a complexity of 8"
  end

  it "has smells with scores" do
    smell = @adapter.smells.first
    smell.score.must_be_kind_of Numeric
  end
end
