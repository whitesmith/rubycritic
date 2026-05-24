# frozen_string_literal: true

require_relative 'integration_test_helper'

describe 'Minimum score' do
  include IntegrationTestHelper

  describe 'Status indicates a success when not using --minimum-score' do
    it 'succeeds without minimum score' do
      create_smelly_file
      result = rubycritic('smelly.rb')

      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'Status indicates an error when score below the minimum' do
    it 'fails when score below minimum' do
      create_smelly_file
      result = rubycritic('--minimum-score 100 smelly.rb')

      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SCORE_BELOW_MINIMUM
    end
  end

  describe 'Status indicates a success when score is above the minimum' do
    it 'succeeds when score above minimum' do
      create_smelly_file
      result = rubycritic('--minimum-score 93 smelly.rb')

      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'Status indicates a success when score is equal the minimum' do
    it 'succeeds when score equals minimum' do
      create_clean_file
      result = rubycritic('--minimum-score 100 clean.rb')

      _(result.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'Prints the score on output' do
    it 'prints score' do
      create_smelly_file
      result = rubycritic('smelly.rb')

      _(result.stdout).must_include 'Score: 93.19'
    end
  end

  describe 'Prints a message informing the score is below the minimum' do
    it 'prints below minimum message' do
      create_empty_file
      result = rubycritic('--minimum-score 101 empty.rb')

      _(result.stdout).must_include 'Score (100.0) is below the minimum 101.0'
    end
  end
end
