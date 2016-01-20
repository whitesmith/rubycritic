require "test_helper"
require "rubycritic/commands/status_reporter"
require "rubycritic/cli/options"

describe Rubycritic::Command::StatusReporter do
  let(:success_status) { Rubycritic::Command::StatusReporter::SUCCESS }
  let(:score_below_minimum) { Rubycritic::Command::StatusReporter::SCORE_BELOW_MINIMUM }

  describe "with default options" do
    before do
      @options = Rubycritic::Cli::Options.new([])
      @options.parse
      @reporter = Rubycritic::Command::StatusReporter.new(@options.to_h)
    end

    it "has a default" do
      @reporter.status.must_equal success_status
      @reporter.status_message.must_be_nil
    end

    it "accept a score" do
      @reporter.score = 50
      @reporter.status.must_equal success_status
      @reporter.status_message.must_equal "Score: 50"
    end
  end

  describe "with minimum-score option" do
    before do
      @options = Rubycritic::Cli::Options.new(["-s", "99"])
      @options.parse
      @reporter = Rubycritic::Command::StatusReporter.new(@options.to_h)
    end

    it "has a default" do
      @reporter.status.must_equal success_status
      @reporter.status_message.must_be_nil
    end

    describe "when score is below minimum" do
      let(:score) { 98 }
      it "should return the correct status" do
        @reporter.score = score
        @reporter.status.must_equal score_below_minimum
        @reporter.status_message.must_equal "Score (98) is below the minimum 99"
      end
    end

    describe "when score is equal the minimum" do
      let(:score) { 99 }
      it "should return the correct status" do
        @reporter.score = score
        @reporter.status.must_equal success_status
        @reporter.status_message.must_equal "Score: 99"
      end
    end

    describe "when score is above the minimum" do
      let(:score) { 100 }
      it "should return the correct status" do
        @reporter.score = score
        @reporter.status.must_equal success_status
        @reporter.status_message.must_equal "Score: 100"
      end
    end
  end
end
