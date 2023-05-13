# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/core/smell'

describe RubyCritic::Smell do
  describe 'attribute readers' do
    before do
      @locations = [RubyCritic::Location.new('./foo', '42')]
      @context = '#bar'
      @message = 'This smells'
      @score = 0
      @type = :complexity
      @smell = RubyCritic::Smell.new(
        locations: @locations,
        context: @context,
        message: @message,
        score: @score,
        type: @type
      )
    end

    it 'has a context reader' do
      _(@smell.context).must_equal @context
    end

    it 'has a locations reader' do
      _(@smell.locations).must_equal @locations
    end

    it 'has a message reader' do
      _(@smell.message).must_equal @message
    end

    it 'has a score reader' do
      _(@smell.score).must_equal @score
    end

    it 'has a type reader' do
      _(@smell.type).must_equal @type
    end
  end

  describe '#at_location?' do
    it 'returns true if the smell has a location that matches the location passed as argument' do
      location = RubyCritic::Location.new('./foo', '42')
      smell = RubyCritic::Smell.new(locations: [location])
      _(smell.at_location?(location)).must_equal true
    end
  end

  describe '#multiple_locations?' do
    it 'returns true if the smell has more than one location' do
      location1 = RubyCritic::Location.new('./foo', '42')
      location2 = RubyCritic::Location.new('./foo', '23')
      smell = RubyCritic::Smell.new(locations: [location1, location2])
      _(smell.multiple_locations?).must_equal true
    end
  end

  describe '#==' do
    it 'returns true if two smells have the same base attributes' do
      attributes = {
        context: '#bar',
        message: 'This smells',
        score: 0,
        type: :complexity
      }
      smell1 = RubyCritic::Smell.new(attributes)
      smell2 = RubyCritic::Smell.new(attributes)
      _(smell1).must_equal smell2
    end
  end

  describe '#doc_url' do
    it 'handles one word type names for reek smells' do
      smell = RubyCritic::Smell.new(type: 'Complexity', analyser: 'reek')

      _(smell.doc_url).must_equal('https://github.com/troessner/reek/blob/master/docs/Complexity.md')
    end

    it 'handles multiple word type names for reek smells' do
      smell = RubyCritic::Smell.new(type: 'TooManyStatements', analyser: 'reek')

      _(smell.doc_url).must_equal('https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md')
    end

    it 'handles flay smells' do
      smell = RubyCritic::Smell.new(type: 'DuplicateCode', analyser: 'flay')

      _(smell.doc_url).must_equal('http://docs.seattlerb.org/flay/')
    end

    it 'handles flog smells' do
      smell = RubyCritic::Smell.new(type: 'VeryHighComplexity', analyser: 'flog')

      _(smell.doc_url).must_equal('http://docs.seattlerb.org/flog/')
    end

    it 'raises an error for unknown analysers' do
      smell = RubyCritic::Smell.new(type: 'FooSmell', analyser: 'foo')
      assert_raises(RuntimeError) { smell.doc_url }
    end
  end

  describe 'default attributes' do
    it 'has :new for status' do
      smell = RubyCritic::Smell.new
      _(smell.status).must_equal(:new)
    end

    it 'is has an empty array for locations' do
      smell = RubyCritic::Smell.new
      _(smell.locations).must_equal([])
    end
  end
end
