# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/version'

describe 'RubyCritic version' do
  it 'is defined' do
    RubyCritic::VERSION.wont_be_nil
  end
end
