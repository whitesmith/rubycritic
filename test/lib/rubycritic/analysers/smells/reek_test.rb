require "analysers_test_helper"
require "rubycritic/analysers/smells/reek"

describe Rubycritic::Analyser::ReekSmells do
  context "when analysing a smelly file" do
    before do
      pathname = Pathname.new("test/samples/reek/smelly.rb")
      @analysed_module = AnalysedModuleDouble.new(:pathname => pathname, :smells => [])
      analysed_modules = [@analysed_module]
      Rubycritic::Analyser::ReekSmells.new(analysed_modules).run
    end

    it "detects its smells" do
      @analysed_module.smells.length.must_equal 2
    end

    it "creates smells with messages" do
      first_smell = @analysed_module.smells.first
      first_smell.message.must_equal "has boolean parameter 'reek'"

      last_smell = @analysed_module.smells.last
      last_smell.message.must_equal "has no descriptive comment"
    end
  end
end
