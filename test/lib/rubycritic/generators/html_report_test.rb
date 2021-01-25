# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/analysers_runner'
require 'rubycritic/generators/html_report'
require 'fakefs_helper'

describe RubyCritic::Generator::HtmlReport do
  describe '#generate_report' do
    around do |example|
      capture_output_streams do
        with_cloned_fs(&example)
      end
    end

    it 'creates the HTML report files' do
      sample_files = Dir['test/samples/**/*.rb']
      create_analysed_modules_collection
      generate_report
      assert File.file? 'test/samples/overview.html'
      overview = File.read 'test/samples/overview.html'
      assert overview.match? '<title>Ruby Critic - Home</title>'
      assert File.file? 'test/samples/code_index.html'
      code_index = File.read 'test/samples/code_index.html'
      sample_files.each do |filename|
        assert code_index.match? filename.sub('.rb', '.html')
      end
    end
  end

  def create_analysed_modules_collection
    RubyCritic::Config.root = 'test/samples'
    RubyCritic::Config.source_control_system = RubyCritic::SourceControlSystem::Git.new
    analyser_runner = RubyCritic::AnalysersRunner.new('test/samples/')
    @analysed_modules_collection = analyser_runner.run
  end

  def generate_report
    report = RubyCritic::Generator::HtmlReport.new(@analysed_modules_collection)
    report.generate_report
  end
end
