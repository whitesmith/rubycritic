require "analysers_test_helper"
require "rubycritic/analysers/smells/rubocop"

describe Rubycritic::Analyser::FlogSmells do
  context "when analysing a complex file" do
    before do
      @analysed_module = AnalysedModuleDouble.new(:path => "test/samples/rubocop/smelly.rb", :smells => [])
      analysed_modules = [@analysed_module]
      Rubycritic::Analyser::RuboCopSmells.new(analysed_modules).run
    end

    it "detects its smells" do
      @analysed_module.smells.length.must_equal 3
    end

    it "creates smells with messages" do
      smell = @analysed_module.smells.first
      smell.message.must_be_instance_of String
    end
  end
end