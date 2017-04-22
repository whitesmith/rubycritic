# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/analysers/helpers/modules_locator'
require 'rubycritic/core/analysed_module'
require 'pathname'

describe RubyCritic::ModulesLocator do
  describe '#names' do
    context 'when a file contains Ruby code' do
      it 'returns the names of all the classes and modules inside the file' do
        analysed_module = RubyCritic::AnalysedModule.new(
          pathname: Pathname.new('test/samples/module_names.rb'),
          methods_count: 1
        )
        RubyCritic::ModulesLocator.new(analysed_module).names
                                  .must_equal ['Foo', 'Foo::Bar', 'Foo::Baz', 'Foo::Qux', 'Foo::Quux::Corge']
      end
    end

    context 'when a file is empty' do
      it 'returns the name of the file titleized' do
        analysed_module = RubyCritic::AnalysedModule.new(
          pathname: Pathname.new('test/samples/empty.rb'),
          methods_count: 1
        )
        RubyCritic::ModulesLocator.new(analysed_module).names.must_equal ['Empty']
      end
    end

    context 'when a file is unparsable' do
      it 'does not blow up and returns the name of the file titleized' do
        analysed_module = RubyCritic::AnalysedModule.new(
          pathname: Pathname.new('test/samples/unparsable.rb'),
          methods_count: 1
        )
        capture_output_streams do
          RubyCritic::ModulesLocator.new(analysed_module).names.must_equal ['Unparsable']
        end
      end
    end

    context 'when a file has no methods' do
      it 'returns the names of all the classes and modules inside the file' do
        analysed_module = RubyCritic::AnalysedModule.new(
          pathname: Pathname.new('test/samples/no_methods.rb'),
          methods_count: 0
        )
        capture_output_streams do
          RubyCritic::ModulesLocator.new(analysed_module).names.must_equal ['Foo::NoMethods']
        end
      end
    end
  end
end
