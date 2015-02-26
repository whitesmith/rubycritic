require "test_helper"
require "rubycritic/analysers/smells/flay"
require "rubycritic/core/analysed_module"
require "pathname"

describe Rubycritic::Analyser::FlaySmells do
  context "when analysing a bunch of files with duplicate code" do
    before do
      @analysed_modules = [
        Rubycritic::AnalysedModule.new(:pathname => Pathname.new("test/samples/flay/smelly.rb")),
        Rubycritic::AnalysedModule.new(:pathname => Pathname.new("test/samples/flay/smelly2.rb"))
      ]
      Rubycritic::Analyser::FlaySmells.new(@analysed_modules).run
    end

    it "detects its smells" do
      @analysed_modules.first.smells?.must_equal true
    end

    it "creates smells with messages" do
      smell = @analysed_modules.first.smells.first
      smell.message.must_be_instance_of String
    end

    it "creates smells with scores" do
      smell = @analysed_modules.first.smells.first
      smell.score.must_be_kind_of Numeric
    end

    it "creates smells with more than one location" do
      smell = @analysed_modules.first.smells.first
      smell.multiple_locations?.must_equal true
    end

    it "calculates the mass of duplicate code" do
      @analysed_modules.first.duplication.must_be(:>, 0)
    end
  end
end
