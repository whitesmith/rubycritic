# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/reporter'

describe RubyCritic::Reporter do
  before do
    RubyCritic::Config.set({})
    RubyCritic::Config.stubs(:no_browser).returns(true)
  end

  it 'creates multiple reports' do
    RubyCritic::Config.stubs(:formats).returns(%i[json lint html])
    create_analysed_modules_collection
    RubyCritic::Reporter.generate_report(@analysed_modules_collection)

    assert(File.exist?('test/samples/report.json'))
    assert(File.exist?('test/samples/lint.txt'))
    assert(File.exist?('test/samples/overview.html'))
  end

  it 'creates a dummy formatter' do
    RubyCritic::Config.stubs(:formatters).returns(['DummyFormatter'])
    class DummyFormatter; end
    formatter = mock
    formatter.expects(:generate_report).returns(true)
    DummyFormatter.expects(:new).once.returns(formatter)
    create_analysed_modules_collection
    assert RubyCritic::Reporter.generate_report(@analysed_modules_collection)
  end

  it 'creates a dummy formatter long path' do
    RubyCritic::Config.stubs(:formatters).returns(['MyTest::DummyFormatter'])
    module MyTest
      class DummyFormatter; end
    end
    formatter = mock
    formatter.expects(:generate_report).returns(true)
    MyTest::DummyFormatter.expects(:new).once.returns(formatter)
    create_analysed_modules_collection
    assert RubyCritic::Reporter.generate_report(@analysed_modules_collection)
  end

  it 'creates and loads a dummy formatter' do
    RubyCritic::Config.stubs(:formatters).returns(['./test/samples/dummy_formatter.rb:Test::DummyFormatter'])
    create_analysed_modules_collection
    assert RubyCritic::Reporter.generate_report(@analysed_modules_collection)
  end

  def create_analysed_modules_collection
    RubyCritic::Config.stubs(:root).returns('./test/samples')
    RubyCritic::Config.stubs(:source_control_system).returns(RubyCritic::SourceControlSystem::Git.new)
    analyser_runner = RubyCritic::AnalysersRunner.new('test/samples/')
    @analysed_modules_collection = analyser_runner.run
  end
end
