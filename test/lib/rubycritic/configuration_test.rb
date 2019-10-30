# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/configuration'

describe RubyCritic::Configuration do
  describe '#root' do
    before do
      RubyCritic::Config.set
      @default = RubyCritic::Config.root
    end

    it 'has a default' do
      _(RubyCritic::Config.root).must_be_instance_of String
    end

    it 'can be set to a relative path' do
      RubyCritic::Config.root = 'foo'
      _(RubyCritic::Config.root).must_equal File.expand_path('foo')
    end

    it 'can be set to an absolute path' do
      RubyCritic::Config.root = '/foo'
      _(RubyCritic::Config.root).must_equal '/foo'
    end

    after do
      RubyCritic::Config.root = @default
    end
  end

  describe '#formats' do
    before do
      RubyCritic::Config.set(formats: [])
    end

    it 'sets html format by default' do
      _(RubyCritic::Config.formats).must_equal [:html]
    end
  end
end
