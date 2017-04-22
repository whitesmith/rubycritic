# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/source_control_systems/base'

describe RubyCritic::SourceControlSystem::Base do
  before do
    RubyCritic::SourceControlSystem::Base.systems.each do |system|
      system.stubs(:supported?).returns(false)
    end
  end

  describe '::create' do
    context 'when a source control system is found' do
      it 'creates an instance of that source control system' do
        RubyCritic::SourceControlSystem::Git.stubs(:supported?).returns(true)
        system = RubyCritic::SourceControlSystem::Base.create
        system.must_be_instance_of RubyCritic::SourceControlSystem::Git
      end
    end

    context 'when no source control system is found' do
      it 'creates a source control system double' do
        capture_output_streams do
          system = RubyCritic::SourceControlSystem::Base.create
          system.must_be_instance_of RubyCritic::SourceControlSystem::Double
        end
      end
    end
  end
end
