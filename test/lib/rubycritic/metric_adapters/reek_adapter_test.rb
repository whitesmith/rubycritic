require "test_helper"
require "rubycritic/analysers/reek"
require "rubycritic/smell_adapters/reek"

describe Rubycritic::SmellAdapter::Reek do
  before do
    @sample_path = "test/samples/reek/smelly.rb"
    reek = Rubycritic::Analyser::Reek.new(@sample_path)
    @adapter = Rubycritic::SmellAdapter::Reek.new(reek)
  end

  it "detects smells" do
    @adapter.smells.wont_be_empty
  end

  it "has smells with locations" do
    smell = @adapter.smells.first
    smell.locations.first.path.must_equal @sample_path
  end

  it "has smells with messages" do
    smell = @adapter.smells.first
    smell.message.must_equal "has boolean parameter 'reek'"
  end
end
