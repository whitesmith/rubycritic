require "test_helper"
require "rubycritic/analysers/smells/flay"
require "rubycritic/core/analysed_module"
require "pathname"

describe Rubycritic::Analyser::FlaySmells do
  before do
    @analysed_module = Rubycritic::AnalysedModule.new(
      :pathname => Pathname.new("test/samples/flay/smelly.rb"),
    )
    analysed_modules = [@analysed_module]
    Rubycritic::Analyser::FlaySmells.new(analysed_modules).run
  end

  it "detects smells and adds them to analysed_modules" do
    @analysed_module.smells.length.must_equal 1
  end

  it "creates smells with messages" do
    smell = @analysed_module.smells.first
    smell.message.must_be_instance_of String
  end

  it "creates smells with scores" do
    smell = @analysed_module.smells.first
    smell.score.must_be_kind_of Numeric
  end

  it "calculates the mass of duplicate code and adds it to analysed_modules" do
    @analysed_module.duplication.must_be(:>, 0)
  end
end
