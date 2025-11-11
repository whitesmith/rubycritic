# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/analysers_runner'
require 'rubycritic/generators/lint_report'

describe RubyCritic::Generator::LintReport do
  describe '#generate_report' do
    before do
      # Reset Reek configuration between tests
      # Config is cached and can leak between tests
      RubyCritic::Reek.instance_variable_set(:@configuration, nil)
    end

    it 'report file has data inside' do
      sample_files = Dir['test/samples/**/*.rb'].reject { |f| File.empty?(f) || f.include?('excluded') }
      create_analysed_modules_collection
      generate_report
      lines = File.readlines('test/samples/lint.txt').map(&:strip).reject(&:empty?)
      analysed_files = lines.map { |line| line.split(':').first }.uniq

      assert_matched_arrays analysed_files, sample_files
    end
  end

  def create_analysed_modules_collection
    RubyCritic::Config.root = 'test/samples'
    RubyCritic::Config.source_control_system = RubyCritic::SourceControlSystem::Git.new
    analyser_runner = RubyCritic::AnalysersRunner.new('test/samples/')
    @analysed_modules_collection = analyser_runner.run
  end

  def generate_report
    report = RubyCritic::Generator::LintReport.new(@analysed_modules_collection)
    report.generate_report
  end
end
