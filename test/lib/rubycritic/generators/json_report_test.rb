# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/analysers_runner'
require 'rubycritic/generators/json_report'
require 'json'
require 'fakefs/safe'

describe RubyCritic::Generator::JsonReport do
  describe '#generate_report' do
    around do |example|
      capture_output_streams do
        with_cloned_fs(&example)
      end
    end

    it 'creates a report file with JSON data inside' do
      sample_files = Dir['test/samples/**/*.rb']
      create_analysed_modules_collection
      generate_report
      data = JSON.parse(File.read('test/samples/report.json'))
      analysed_files = data['analysed_modules'].map { |h| h['path'] }.uniq
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
    report = RubyCritic::Generator::JsonReport.new(@analysed_modules_collection)
    report.generate_report
  end
end
