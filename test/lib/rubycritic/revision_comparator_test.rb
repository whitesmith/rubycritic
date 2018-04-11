# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/revision_comparator'

describe RubyCritic::RevisionComparator do
  subject { RubyCritic::RevisionComparator.new([]) }

  describe '#set_statuses' do
    context 'in a SCS with :revision? == false' do
      before do
        RubyCritic::Config.expects(:source_control_system)
                          .at_least_once
                          .returns(stub(revision?: false))
      end

      it 'does not attempt to compare with previous results' do
        subject.expects(:load_cached_analysed_modules).never
        result = subject.set_statuses([])
        result.must_equal([])
      end
    end

    context 'in a SCS with :revision? == true' do
      before do
        RubyCritic::Config.expects(:source_control_system)
                          .at_least_once
                          .returns(stub(revision?: true))
      end

      context 'without previously cached results' do
        before do
          subject.expects(:revision_file).returns('foo')
          File.expects(:file?).with('foo').returns(false)
        end

        it 'does not load them' do
          RubyCritic::Serializer.expects(:new).never
          subject.set_statuses([])
        end

        it 'does not invoke RubyCritic::SmellsStatusSetter' do
          RubyCritic::SmellsStatusSetter.expects(:set).never
          subject.set_statuses([])
        end
      end

      context 'with previously cached results' do
        before do
          subject.expects(:revision_file).twice.returns('foo')
          File.expects(:file?).with('foo').returns(true)
          RubyCritic::Serializer.expects(:new).with('foo').returns(stub(load: []))
        end

        it 'loads them' do
          subject.set_statuses([])
        end

        it 'invokes RubyCritic::SmellsStatusSetter' do
          RubyCritic::SmellsStatusSetter.expects(:set).once
          subject.set_statuses([])
        end
      end
    end
  end
end
