# frozen_string_literal: true

require 'analysers_test_helper'
require 'rubycritic/analysers/smells/reek'

describe RubyCritic::Analyser::ReekSmells do
  context 'when analysing a smelly file' do
    before do
      pathname = Pathname.new('test/samples/reek/smelly.rb')
      @analysed_module = AnalysedModuleDouble.new(pathname: pathname, smells: [])
      analysed_modules = [@analysed_module]
      RubyCritic::Analyser::ReekSmells.new(analysed_modules).run
    end

    it 'detects its smells' do
      _(@analysed_module.smells.length).must_equal 2
    end

    it 'respects the .reek file' do
      messages = @analysed_module.smells.map(&:message)
      _(messages).wont_include "has the parameter name 'a'"
    end

    it 'creates smells with messages' do
      first_smell = @analysed_module.smells.first
      _(first_smell.message).must_equal "has boolean parameter 'reek'"

      last_smell = @analysed_module.smells.last
      _(last_smell.message).must_equal 'has no descriptive comment'
    end
  end

  context 'when analysing a excluded smelly file' do
    before do
      pathname = Pathname.new('test/samples/reek/excluded_smelly.rb')
      @analysed_module = AnalysedModuleDouble.new(pathname: pathname, smells: [])
      analysed_modules = [@analysed_module]
      RubyCritic::Analyser::ReekSmells.new(analysed_modules).run
    end

    it 'dont analyse the file' do
      _(@analysed_module.smells.length).must_equal 0
    end
  end
end
