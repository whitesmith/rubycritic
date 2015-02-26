require "analysers_test_helper"
require "rubycritic/analysers/smells/reek"

describe Rubycritic::Analyser::ReekSmells do
  context "when analysing a smelly file" do
    before do
      @analysed_module = AnalysedModuleDouble.new(:path => "test/samples/reek/smelly.rb", :smells => [])
      analysed_modules = [@analysed_module]
      Rubycritic::Analyser::ReekSmells.new(analysed_modules).run
    end

    it "detects its smells" do
      @analysed_module.smells.length.must_equal 1
    end

    it "creates smells with messages" do
      smell = @analysed_module.smells.first
      smell.message.must_equal "has boolean parameter 'reek'"
    end
  end

  context "when analysing a file with smells ignored in config.reek" do
    before do
      @analysed_module = AnalysedModuleDouble.new(:path => "test/samples/reek/not_smelly.rb", :smells => [])
      analysed_modules = [@analysed_module]
      Rubycritic::Analyser::ReekSmells.new(analysed_modules).run
    end

    it "does not detect those smells" do
      @analysed_module.smells.must_be_empty
    end
  end
end
