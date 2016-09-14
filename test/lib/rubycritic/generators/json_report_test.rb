# frozen_string_literal: true
require 'test_helper'
require 'rubycritic/core/analysed_modules_collection'
require 'rubycritic/generators/json_report'
require 'json'
require 'fakefs/safe'

describe RubyCritic::Generator::JsonReport do
  describe '#generate_report' do
    before(:each) do
      FakeFS.activate!
      create_analysed_modules_collection
      generate_report
    end

    after(:each) { FakeFS.deactivate! }

    it 'creates a report.json file' do
      assert File.file?('test/samples/report.json'), 'expected report.json file to be created'
    end

    it 'report file has data inside' do
      data = File.read('test/samples/report.json')
      assert data != '', 'expected report file not to be empty'
    end
  end

  def create_analysed_modules_collection
    @analysed_modules_collection = RubyCritic::AnalysedModulesCollection.new('test/samples/')
    RubyCritic::Config.root = 'test/samples'
  end

  def generate_report
    report = RubyCritic::Generator::JsonReport.new(@analysed_modules_collection)
    report.generate_report
  end
end
