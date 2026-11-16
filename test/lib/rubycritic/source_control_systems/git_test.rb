# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/source_control_systems/base'

describe RubyCritic::SourceControlSystem::Git do
  describe '.switch_branch' do
    it 'should not raise NoMethodError' do
      RubyCritic::SourceControlSystem::Git.stubs(:uncommitted_changes).returns('')
      RubyCritic::SourceControlSystem::Git.expects(:git)
      RubyCritic::SourceControlSystem::Git.switch_branch('_branch_')
    end

    it 'raises a RubyCritic::Error without checking out when there are uncommitted changes' do
      git = RubyCritic::SourceControlSystem::Git
      git.stubs(:uncommitted_changes).returns(':100644 100644 abc def M\tfoo.rb')
      git.expects(:git).never
      git.expects(:abort).never

      error = assert_raises(RubyCritic::Error) { git.switch_branch('_branch_') }
      _(error.message).must_include 'Uncommitted changes are present'
    end
  end

  describe '#churn' do
    let(:git) { RubyCritic::SourceControlSystem::Git.new }
    let(:churn_after) { 'churn_after_date' }
    let(:paths) { ['path/1', 'path/2'] }

    before do
      RubyCritic::SourceControlSystem::Git.stubs(:git).returns('')
      RubyCritic::Config.stubs(:churn_after).returns(churn_after)
      RubyCritic::Config.stubs(:paths).returns(paths)
    end

    it 'should pass the churn_after and path options to new Churn objects' do
      RubyCritic::SourceControlSystem::Git::Churn.expects(:new).with(
        churn_after: churn_after, paths: paths
      )

      git.churn
    end
  end
end
