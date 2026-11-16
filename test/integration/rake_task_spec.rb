# frozen_string_literal: true

require_relative 'integration_test_helper'

describe 'Rake task' do
  include IntegrationTestHelper

  describe 'paths attribute is respected' do
    it 'runs rake rubycritic with paths' do
      create_smelly_file
      result = rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.options = '--no-browser -f console'
        end
      RUBY

      _(result.stdout).must_include '(HighComplexity) AllTheMethods#method_missing has a flog score of 27'
      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'name option changes the task name' do
    it 'runs rake silky' do
      create_smelly_file
      result = rake('silky', <<~RUBY)
        RubyCritic::RakeTask.new('silky') do |t|
          t.paths = FileList['smelly.*']
          t.verbose = true
          t.options = '--no-browser'
        end
      RUBY

      _(result.stdout).must_include 'Running `silky` rake command'
    end
  end

  describe 'verbose prints details about the execution' do
    it 'runs rake rubycritic with verbose' do
      create_smelly_file
      result = rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.verbose = true
          t.options = '--no-browser'
        end
      RUBY

      _(result.stdout).must_include '!!! Running `rubycritic` rake command'
      _(result.stdout).must_include '!!! Inspecting smelly.rb with options --no-browser'
    end
  end

  describe 'respect --minimum-score' do
    it 'fails when score below minimum' do
      create_smelly_file
      result = rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.verbose = true
          t.options = '--no-browser -f console --minimum-score 95'
        end
      RUBY

      _(result.stdout).must_include 'Score (93.19) is below the minimum 95'
      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SCORE_BELOW_MINIMUM
    end
  end

  describe 'fail_on_error when false will exit 0 even when RubyCritic fails' do
    it 'succeeds despite low score' do
      create_smelly_file
      result = rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.fail_on_error = false
          t.options = '--no-browser -f console --minimum-score 95'
        end
      RUBY

      _(result.stdout).must_include 'Score (93.19) is below the minimum 95'
      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end

    it 'succeeds when comparing branches fails with uncommitted changes' do
      create_smelly_file
      git = 'git -c user.name=test -c user.email=test@example.com -c commit.gpgsign=false'
      system("#{git} init -q && #{git} checkout -q -b main && #{git} add smelly.rb && #{git} commit -q -m init " \
             "&& #{git} checkout -q -b feature", exception: true)
      File.write('smelly.rb', "# dirty\n", mode: 'a')

      result = rake('rubycritic', <<~RUBY)
        RubyCritic::RakeTask.new do |t|
          t.paths = FileList['smelly.*']
          t.fail_on_error = false
          t.options = '--no-browser -f console -b main'
        end
      RUBY

      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
      _(result.stderr).must_include 'Error: Uncommitted changes are present'
    end
  end
end
