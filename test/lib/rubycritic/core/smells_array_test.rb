# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/core/smell'

describe 'Array of Smells' do
  it 'is sortable' do
    location1 = RubyCritic::Location.new('./foo', 42)
    location2 = RubyCritic::Location.new('./bar', 23)
    location3 = RubyCritic::Location.new('./bar', 16)
    smell1 = RubyCritic::Smell.new(locations: [location1])
    smell2 = RubyCritic::Smell.new(locations: [location2])
    smell3 = RubyCritic::Smell.new(locations: [location3])
    [smell1, smell2, smell3].sort.must_equal [smell3, smell2, smell1]
  end

  it 'implements set intersection' do
    smell1 = RubyCritic::Smell.new(context: '#bar')
    smell2 = RubyCritic::Smell.new(context: '#bar')
    smell3 = RubyCritic::Smell.new(context: '#foo')
    ([smell1, smell3] & [smell2]).must_equal [smell1]
  end

  it 'implements set union' do
    smell1 = RubyCritic::Smell.new(context: '#bar')
    smell2 = RubyCritic::Smell.new(context: '#bar')
    smell3 = RubyCritic::Smell.new(context: '#foo')
    ([smell1, smell3] | [smell2]).must_equal [smell1, smell3]
  end
end
