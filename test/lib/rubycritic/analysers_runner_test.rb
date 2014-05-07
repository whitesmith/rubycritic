require "test_helper"
require "rubycritic/analysers_runner"

describe Rubycritic::AnalysersRunner do
  describe "#run" do
    it "returns an array containing smell adapters" do
      smell_adapters = Rubycritic::AnalysersRunner.new("test/samples/analysers_runner/empty.rb").run
      smell_adapters.each { |adapter| adapter.must_respond_to(:smells) }
    end
  end
end
