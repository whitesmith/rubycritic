# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/core/smell'
require 'rubycritic/smells_status_setter'

describe RubyCritic::SmellsStatusSetter do
  describe '::smells' do
    before do
      @smell = RubyCritic::Smell.new(context: '#bar')
      @smells = [@smell]
    end

    it 'marks old smells' do
      RubyCritic::SmellsStatusSetter.set(@smells, @smells)
      @smell.status.must_equal :old
    end

    it 'marks new smells' do
      RubyCritic::SmellsStatusSetter.set([], @smells)
      @smell.status.must_equal :new
    end
  end
end
