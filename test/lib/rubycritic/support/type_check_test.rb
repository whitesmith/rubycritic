# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/core/smell'
require 'rubycritic/core/analysed_module'

describe 'TypeCheck' do
  describe RubyCritic::Smell do
    it 'allows a value of the declared type' do
      smell = RubyCritic::Smell.new
      smell.cost = 42

      _(smell.cost).must_equal 42
    end

    it 'allows a subclass of the declared type (Integer for Numeric)' do
      smell = RubyCritic::Smell.new
      smell.score = 3

      _(smell.score).must_equal 3
    end

    it 'allows nil for any attribute' do
      smell = RubyCritic::Smell.new
      smell.message = nil

      _(smell.message).must_be_nil
    end

    it 'accepts either member of a union type (String or Symbol for type)' do
      smell = RubyCritic::Smell.new
      smell.type = 'DuplicateCode'

      _(smell.type).must_equal 'DuplicateCode'
      smell.type = :complexity

      _(smell.type).must_equal :complexity
    end

    it 'raises a TypeError when assigning the wrong type' do
      smell = RubyCritic::Smell.new
      error = _ { smell.cost = 'expensive' }.must_raise TypeError
      _(error.message).must_match(/Smell#cost= expected Numeric or nil, got String/)
    end

    it 'raises when assigning the wrong type to a union attribute' do
      smell = RubyCritic::Smell.new
      error = _ { smell.type = 123 }.must_raise TypeError
      _(error.message).must_match(/Smell#type= expected String \| Symbol or nil, got Integer/)
    end

    it 'enforces the type through the initializer' do
      _ { RubyCritic::Smell.new(locations: 'not-an-array') }.must_raise TypeError
    end

    it 'constructs with realistic arguments without raising' do
      smell = RubyCritic::Smell.new(
        context: '#bar',
        cost: 16,
        locations: [RubyCritic::Location.new('./foo', '42')],
        message: 'This smells',
        score: 0,
        type: 'DuplicateMethodCall',
        analyser: 'flog'
      )

      _(smell.analyser).must_equal 'flog'
    end
  end

  describe RubyCritic::AnalysedModule do
    it 'allows an Integer for a Numeric attribute (coverage)' do
      mod = RubyCritic::AnalysedModule.new
      mod.coverage = 0

      _(mod.coverage).must_equal 0
    end

    it 'allows a Float for a Numeric attribute (coverage)' do
      mod = RubyCritic::AnalysedModule.new
      mod.coverage = 87.5

      _(mod.coverage).must_equal 87.5
    end

    it 'preserves the Float::INFINITY default' do
      _(RubyCritic::AnalysedModule.new.complexity).must_equal Float::INFINITY
    end

    it 'accumulates duplication through the writer (+=)' do
      mod = RubyCritic::AnalysedModule.new
      mod.duplication += 18

      _(mod.duplication).must_equal 18
    end

    it 'raises a TypeError when assigning the wrong type to pathname' do
      mod = RubyCritic::AnalysedModule.new
      error = _ { mod.pathname = 'foo.rb' }.must_raise TypeError
      _(error.message).must_match(/AnalysedModule#pathname= expected Pathname \| FakeFS::Pathname or nil, got String/)
    end

    it 'raises when assigning a non-Array to smells' do
      _ { RubyCritic::AnalysedModule.new.smells = 5 }.must_raise TypeError
    end

    it 'constructs with realistic arguments without raising' do
      mod = RubyCritic::AnalysedModule.new(
        name: 'Foo',
        pathname: Pathname.new('foo.rb'),
        smells: [],
        churn: 3,
        complexity: 12.5,
        methods_count: 4
      )

      _(mod.name).must_equal 'Foo'
    end
  end

  describe 'the TypeCheck error type' do
    it 'is a kind of the standard TypeError' do
      _(TypeCheckHelper::TypeError.ancestors).must_include TypeError
    end
  end
end
