require "test_helper"
require "rubycritic/analysers/smells/flay"
require "rubycritic/core/analysed_file"
require "pathname"

describe Rubycritic::Analyser::FlaySmells do
  before do
    @analysed_file = Rubycritic::AnalysedFile.new(
      :pathname => Pathname.new("test/samples/flay/smelly.rb"),
      :smells => [],
      :duplication => 0
    )
    analysed_files = [@analysed_file]
    Rubycritic::Analyser::FlaySmells.new(analysed_files).run
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

  it "calculates the mass of duplicate code and adds it to analysed_files" do
    @analysed_file.duplication.must_be(:>, 0)
  end
end
