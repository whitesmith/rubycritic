# frozen_string_literal: true

require 'analysers_test_helper'
require 'rubycritic/analysers/helpers/methods_counter'

describe RubyCritic::MethodsCounter do
  describe '#count' do
    context 'when a file contains Ruby code' do
      it 'calculates the number of methods' do
        analysed_module = AnalysedModuleDouble.new(path: 'test/samples/methods_count.rb')
        RubyCritic::MethodsCounter.new(analysed_module).count.must_equal 2
      end
    end

    context 'when a file is empty' do
      it 'returns 0 as the number of methods' do
        analysed_module = AnalysedModuleDouble.new(path: 'test/samples/empty.rb')
        RubyCritic::MethodsCounter.new(analysed_module).count.must_equal 0
      end
    end

    context 'when a file is unparsable' do
      it 'does not blow up and returns 0 as the number of methods' do
        analysed_module = AnalysedModuleDouble.new(path: 'test/samples/unparsable.rb')
        capture_output_streams do
          RubyCritic::MethodsCounter.new(analysed_module).count.must_equal 0
        end
      end
    end
  end
end
