require "analysers_test_helper"
require "rubycritic/analysers/smells/flog"

describe Rubycritic::Analyser::FlogSmells do
  context "when analysing a complex file" do
    before do
      @analysed_module = AnalysedModuleDouble.new(:path => "test/samples/flog/smelly.rb", :smells => [])
      analysed_modules = [@analysed_module]
      Rubycritic::Analyser::FlogSmells.new(analysed_modules).run
    end

    it "detects its smells" do
      @analysed_module.smells.length.must_equal 1
    end

    it "creates smells with messages" do
      smell = @analysed_module.smells.first
      smell.message.must_be_instance_of String
    end

    it "creates smells with scores" do
      smell = @analysed_module.smells.first
      smell.score.must_be :>, 0
    end
  end
end
