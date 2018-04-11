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
      @smell.context.must_equal @context
    end

    it 'has a locations reader' do
      @smell.locations.must_equal @locations
    end

    it 'has a message reader' do
      @smell.message.must_equal @message
    end

    it 'has a score reader' do
      @smell.score.must_equal @score
    end

    it 'has a type reader' do
      @smell.type.must_equal @type
    end
  end

  describe '#at_location?' do
    it 'returns true if the smell has a location that matches the location passed as argument' do
      location = RubyCritic::Location.new('./foo', '42')
      smell = RubyCritic::Smell.new(locations: [location])
      smell.at_location?(location).must_equal true
    end
  end

  describe '#multiple_locations?' do
    it 'returns true if the smell has more than one location' do
      location1 = RubyCritic::Location.new('./foo', '42')
      location2 = RubyCritic::Location.new('./foo', '23')
      smell = RubyCritic::Smell.new(locations: [location1, location2])
      smell.multiple_locations?.must_equal true
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
      smell1.must_equal smell2
    end
  end

  describe '#doc_url' do
    it 'handles one word type names for reek smells' do
      smell = RubyCritic::Smell.new(type: 'Complexity', analyser: 'reek')

      smell.doc_url.must_equal('https://github.com/troessner/reek/blob/master/docs/Complexity.md')
    end

    it 'handles multiple word type names for reek smells' do
      smell = RubyCritic::Smell.new(type: 'TooManyStatements', analyser: 'reek')

      smell.doc_url.must_equal('https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md')
    end

    it 'handles flay smells' do
      smell = RubyCritic::Smell.new(type: 'DuplicateCode', analyser: 'flay')

      smell.doc_url.must_equal('http://docs.seattlerb.org/flay/')
    end

    it 'handles flog smells' do
      smell = RubyCritic::Smell.new(type: 'VeryHighComplexity', analyser: 'flog')

      smell.doc_url.must_equal('http://docs.seattlerb.org/flog/')
    end

    it 'raises an error for unknown analysers' do
      smell = RubyCritic::Smell.new(type: 'FooSmell', analyser: 'foo')
      assert_raises { smell.doc_url }
    end
  end
end
