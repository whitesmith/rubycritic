# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/generators/console_report'
require 'rubycritic/core/rating'
require 'rubycritic/core/smell'

describe RubyCritic::Generator::ConsoleReport do
  describe '#generate_report' do
    before do
      @mock_analysed_module = mock_analysed_module
      capture_output_streams do
        report = RubyCritic::Generator::ConsoleReport.new([@mock_analysed_module])
        report.generate_report
        @output = $stdout.tap(&:rewind).read
      end
    end

    it 'outputs the report to the stdout' do
      assert !@output.empty?, 'expected report to be output to stdout'
    end

    it "starts the report with the module's name" do
      lines = @output.split("\n")
      assert lines[0][/#{mock_analysed_module.name}/]
    end

    it "includes the module's rating in the report" do
      assert output_contains?('Rating', @mock_analysed_module.rating)
    end

    it "includes the module's churn metric in the report" do
      assert output_contains?('Churn', @mock_analysed_module.churn)
    end

    it "includes the module's complexity in the report" do
      assert output_contains?('Complexity', @mock_analysed_module.complexity)
    end

    it "includes the module's duplication metric in the report" do
      assert output_contains?('Duplication', @mock_analysed_module.duplication)
    end

    it 'includes the number of smells in the report' do
      assert output_contains?('Smells', @mock_analysed_module.smells.count)
    end

    it 'includes the smell and its attributes in the report' do
      @mock_analysed_module.smells.each do |smell|
        assert output_contains?(smell), 'expected smell type and context to be reported'
        smell.locations.each do |location|
          assert output_contains?(location), 'expected all smell locations to be reported'
        end
      end
    end

    def output_contains?(*strs)
      @lines ||= @output.split("\n")
      expr = strs.map(&:to_s).map! { |s| Regexp.escape(s) }.join('.*')
      @lines.any? { |l| l[/#{expr}/] }
    end

    def mock_analysed_module
      OpenStruct.new(
        name: 'TestModule',
        rating: RubyCritic::Rating.from_cost(3),
        churn: 10,
        complexity: 0,
        duplication: 20,
        smells: [mock_smell]
      )
    end

    def mock_smell
      smell = RubyCritic::Smell.new
      smell.locations << RubyCritic::Location.new(__FILE__, 3)
      smell.type = 'SmellySmell'
      smell.context = 'You'
      smell.message = 'Seriously, take a shower or something'
      smell
    end
  end
end
