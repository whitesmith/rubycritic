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
  end
end
