# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/reporter'

describe RubyCritic::Reporter do
  it 'creates multiple reports' do
    RubyCritic::Config.set(formats: %i[json lint html], no_browser: true)
    create_analysed_modules_collection
    RubyCritic::Reporter.generate_report(@analysed_modules_collection)

    assert(File.exist?('test/samples/report.json'))
    assert(File.exist?('test/samples/lint.txt'))
    assert(File.exist?('test/samples/overview.html'))
  end

  def create_analysed_modules_collection
    RubyCritic::Config.root = 'test/samples'
    RubyCritic::Config.source_control_system = RubyCritic::SourceControlSystem::Git.new
    analyser_runner = RubyCritic::AnalysersRunner.new('test/samples/')
    @analysed_modules_collection = analyser_runner.run
  end
end
