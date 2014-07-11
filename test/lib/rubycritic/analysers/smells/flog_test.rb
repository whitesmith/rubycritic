require "analysers_test_helper"
require "rubycritic/analysers/smells/flog"

describe Rubycritic::Analyser::FlogSmells do
  before do
    @analysed_file = AnalysedFileDouble.new(:path => "test/samples/flog/smelly.rb", :smells => [])
    analysed_files = [@analysed_file]
    Rubycritic::Analyser::FlogSmells.new(analysed_files).run
  end

  it "detects smells and adds them to analysed_files" do
    @analysed_file.smells.length.must_equal 1
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
