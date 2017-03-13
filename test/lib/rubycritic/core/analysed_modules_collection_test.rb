# frozen_string_literal: true
require 'test_helper'
require 'rubycritic/core/analysed_modules_collection'

describe RubyCritic::AnalysedModulesCollection do
  subject { RubyCritic::AnalysedModulesCollection.new(paths) }

  describe '.new' do
    context 'with an empty path' do
      let(:paths) { '' }

      it 'returns an empty collection' do
        subject.count.must_equal 0
      end
    end

    context 'with a list of files' do
      let(:paths) { %w(test/samples/doesnt_exist.rb test/samples/unparsable.rb test/samples/empty.rb) }

      it 'registers one AnalysedModule element per existent file' do
        subject.count.must_equal 2
        subject.all? { |a| a.is_a?(RubyCritic::AnalysedModule) }.must_equal true
      end
    end

    context 'with a directory' do
      let(:paths) { 'test/samples/' }

      it 'recursively registers all files' do
        subject.count.must_equal Dir['test/samples/**/*.rb'].count
      end
    end

    context 'with redundant paths' do
      let(:paths) { %w(test/samples/flog test/samples/flog/complex.rb) }

      it 'returns a redundant collection' do
        subject.count.must_equal 3
      end
    end

    context 'with a list of files and initializing analysed modules with pre existing values' do
      let(:paths) { %w(test/samples/empty.rb) }
      let(:analysed_modules) do
        [RubyCritic::AnalysedModule.new(pathname: Pathname.new('test/samples/empty.rb'), name: 'Name', smells: [],
                                        churn: 2, committed_at: Time.now, complexity: 2, duplication: 0,
                                        methods_count: 2)]
      end

      it 'registers one AnalysedModule element per existent file' do
        analysed_modules_collection = RubyCritic::AnalysedModulesCollection.new(paths, analysed_modules)
        analysed_modules_collection.count.must_equal 1
        analysed_module = analysed_modules_collection.first
        analysed_module.name.must_equal 'Name'
        analysed_module.churn.must_equal 2
        analysed_module.complexity.must_equal 2
        analysed_module.duplication.must_equal 0
        analysed_module.methods_count.must_equal 2
      end
    end
  end

  describe 'querying analysed_modules_collection' do
    subject { RubyCritic::AnalysedModulesCollection.new(paths, analysed_modules) }

    context 'with a list of files and initializing analysed modules with pre existing values' do
      let(:paths) { %w(test/samples/empty.rb test/samples/unparsable.rb) }
      let(:analysed_modules) do
        [RubyCritic::AnalysedModule.new(pathname: Pathname.new('test/samples/empty.rb'), name: 'Empty'),
         RubyCritic::AnalysedModule.new(pathname: Pathname.new('test/samples/unparsable.rb'), name: 'Unparsable')]
      end

      it 'registers one AnalysedModule element per existent file' do
        subject.count.must_equal 2
        subject.where(['test/samples/empty.rb']).count.must_equal 1
        subject.where(['test/samples/unparsable.rb']).count.must_equal 1
      end
    end
  end

  describe '#score' do
    context 'with no modules' do
      let(:paths) { '' }

      it 'returns zero' do
        subject.score.must_equal 0.0
      end
    end

    context 'with not analysed modules' do
      let(:paths) { 'test/samples/flog' }

      it 'returns zero' do
        subject.score.must_equal 0.0
      end
    end

    context 'with analysed modules' do
      before do
        subject.each_with_index do |mod, i|
          mod.expects(:cost).returns costs[i]
        end
      end

      let(:paths) { %w(test/samples/flog test/samples/flay) }

      context 'with perfect modules' do
        let(:costs) { [0.0, 0.0, 0.0, 0.0] }

        it 'returns the maximum score' do
          subject.score.must_equal 100.0
        end
      end

      context 'with very bad modules' do
        let(:costs) { [16.0, 16.0, 16.0, 16.0] }

        it 'returns zero' do
          subject.score.must_equal 0.0
        end
      end

      context 'with horrible modules' do
        let(:costs) { [32.0, 32.0, 32.0, 32.0] }

        it 'returns zero' do
          subject.score.must_equal 0.0
        end
      end

      context 'with mixed modules' do
        let(:costs) { [32.0, 2.0, 0.0, 2.0] }

        it 'properly calculates the score' do
          subject.score.must_equal 43.75
        end
      end

      context 'with a module above the cost limit' do
        let(:costs) { [220.0, 2.0, 0.0, 2.0] }

        it 'reduces the impact in the result' do
          subject.score.must_equal 43.75
        end
      end
    end
  end
end
