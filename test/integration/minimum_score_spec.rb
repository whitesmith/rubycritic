# frozen_string_literal: true

require_relative 'integration_test_helper'

describe 'Minimum score' do
  include IntegrationTestHelper

  before do
    setup_aruba
  end

  describe 'Status indicates a success when not using --minimum-score' do
    it 'succeeds without minimum score' do
      create_smelly_file
      rubycritic('smelly.rb')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'Status indicates an error when score below the minimum' do
    it 'fails when score below minimum' do
      create_smelly_file
      rubycritic('--minimum-score 100 smelly.rb')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SCORE_BELOW_MINIMUM
    end
  end

  describe 'Status indicates a success when score is above the minimum' do
    it 'succeeds when score above minimum' do
      create_smelly_file
      rubycritic('--minimum-score 93 smelly.rb')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'Status indicates a success when score is equal the minimum' do
    it 'succeeds when score equals minimum' do
      create_clean_file
      rubycritic('--minimum-score 100 clean.rb')

      _(last_command_started.exit_status).must_equal RubyCritic::Command::StatusReporter::SUCCESS
    end
  end

  describe 'Prints the score on output' do
    it 'prints score' do
      create_smelly_file
      rubycritic('smelly.rb')

      _(last_command_started.stdout).must_include 'Score: 93.19'
    end
  end

  describe 'Prints a message informing the score is below the minimum' do
    it 'prints below minimum message' do
      create_empty_file
      rubycritic('--minimum-score 101 empty.rb')

      _(last_command_started.stdout).must_include 'Score (100.0) is below the minimum 101.0'
    end
  end
end
