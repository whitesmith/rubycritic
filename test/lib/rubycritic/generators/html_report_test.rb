# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/analysers_runner'
require 'rubycritic/generators/html_report'
require 'rubycritic/browser'
require 'fakefs_helper'

describe RubyCritic::Generator::HtmlReport do
  describe '#generate_report' do
    around do |example|
      capture_output_streams do
        with_cloned_fs(&example)
      end
    end

    context 'when base branch does not contain the compared file' do
      it 'still works' do
        create_analysed_modules_collection

        generate_report
      end
    end
  end

  def create_analysed_modules_collection
    RubyCritic::Config.set(root: 'test/samples')
    RubyCritic::Config.base_root_directory = 'test/samples'
    RubyCritic::Config.feature_root_directory = 'test/samples'
    RubyCritic::Config.compare_root_directory = 'test/samples'
    RubyCritic::Config.source_control_system = RubyCritic::SourceControlSystem::Git.new
    base_branch_collection = RubyCritic::AnalysedModulesCollection.new(['test/sample/base_branch_file.rb'])
    RubyCritic::Config.base_branch_collection = base_branch_collection
    RubyCritic::Config.mode = :compare_branches

    analyser_runner = RubyCritic::AnalysersRunner.new('test/samples/feature_branch_file.rb')
    @analysed_modules_collection = analyser_runner.run
  end

  def generate_report
    report = RubyCritic::Generator::HtmlReport.new(@analysed_modules_collection)
    report.generate_report
  end
end
