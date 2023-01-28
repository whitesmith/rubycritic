# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/configuration'
require 'rubycritic/configurations/command_parser'

describe RubyCritic::Configurations::CommandParser do
  context '#parse' do
    it 'returns :defaut' do
      RubyCritic::Config.set
      _(RubyCritic::Config.command).must_equal :default
    end

    it 'returns :version' do
      RubyCritic::Config.set(mode: :version)
      _(RubyCritic::Config.command).must_equal :version
    end

    it 'returns :help' do
      RubyCritic::Config.set(mode: :help_text)
      _(RubyCritic::Config.command).must_equal :help
    end
  end
end
