require "analysers_test_helper"
require "rubycritic/analysers/smells/reek"

describe Rubycritic::Analyser::ReekSmells do
  context "when analysing a smelly file" do
    before do
      @analysed_file = AnalysedFileDouble.new(:path => "test/samples/reek/smelly.rb", :smells => [])
      analysed_files = [@analysed_file]
      Rubycritic::Analyser::ReekSmells.new(analysed_files).run
    end

    it "detects smells and adds them to analysed_files" do
      @analysed_file.smells.length.must_equal 1
    end

    it "creates smells with messages" do
      smell = @analysed_file.smells.first
      smell.message.must_equal "has boolean parameter 'reek'"
    end
  end

  context "when analysing a file with smells ignored in config.reek" do
    before do
      @analysed_file = AnalysedFileDouble.new(:path => "test/samples/reek/not_smelly.rb", :smells => [])
      analysed_files = [@analysed_file]
      Rubycritic::Analyser::ReekSmells.new(analysed_files).run
    end

    it "does not detect smells and does not add them to analysed files" do
      @analysed_file.smells.must_be_empty
    end
  end
end
