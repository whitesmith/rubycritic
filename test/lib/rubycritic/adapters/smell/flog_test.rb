require "test_helper"
require "rubycritic/adapters/smell/flog"

describe Rubycritic::SmellAdapter::Flog do
  before do
    @analysed_file = AnalysedFileDouble.new(:path => "test/samples/flog/smelly.rb", :smells => [])
    analysed_files = [@analysed_file]
    Rubycritic::SmellAdapter::Flog.new(analysed_files).smells
  end

  it "detects smells and adds them to analysed_files" do
    @analysed_file.smells.wont_be_empty
  end

  it "creates smells with messages" do
    smell = @analysed_file.smells.first
    smell.message.must_be_instance_of String
  end

  it "creates smells with scores" do
    smell = @analysed_file.smells.first
    smell.score.must_be_kind_of Numeric
  end
end

class AnalysedFileDouble < OpenStruct; end
