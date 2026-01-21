# frozen_string_literal: true

require_relative 'integration_test_helper'

describe 'Rake task' do
  include IntegrationTestHelper

  before do
    setup_aruba
  end

  describe 'paths attribute is respected' do
    it 'runs rake rubycritic with paths' do
      create_smelly_file
      rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.options = '--no-browser -f console'
        end
      RUBY

      _(last_command_started.stdout).must_include '(HighComplexity) AllTheMethods#method_missing has a flog score of 27'
      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'name option changes the task name' do
    it 'runs rake silky' do
      create_smelly_file
      rake('silky', <<~RUBY)
        RubyCritic::RakeTask.new('silky') do |t|
          t.paths = FileList['smelly.*']
          t.verbose = true
          t.options = '--no-browser'
        end
      RUBY

      _(last_command_started.stdout).must_include 'Running `silky` rake command'
    end
  end

  describe 'verbose prints details about the execution' do
    it 'runs rake rubycritic with verbose' do
      create_smelly_file
      rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.verbose = true
          t.options = '--no-browser'
        end
      RUBY

      _(last_command_started.stdout).must_include '!!! Running `rubycritic` rake command'
      _(last_command_started.stdout).must_include '!!! Inspecting smelly.rb with options --no-browser'
    end
  end

  describe 'respect --minimum-score' do
    it 'fails when score below minimum' do
      create_smelly_file
      rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.verbose = true
          t.options = '--no-browser -f console --minimum-score 95'
        end
      RUBY

      _(last_command_started.stdout).must_include 'Score (93.19) is below the minimum 95'
      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SCORE_BELOW_MINIMUM
    end
  end

  describe 'fail_on_error when false will exit 0 even when RubyCritic fails' do
    it 'succeeds despite low score' do
      create_smelly_file
      rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.fail_on_error = false
          t.options = '--no-browser -f console --minimum-score 95'
        end
      RUBY

      _(last_command_started.stdout).must_include 'Score (93.19) is below the minimum 95'
      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end
end
