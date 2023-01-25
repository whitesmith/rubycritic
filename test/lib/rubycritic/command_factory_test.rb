# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/command_factory'

describe RubyCritic::CommandFactory do
  context '.create' do
    it 'returns version command' do
      parsed_options = {mode: :version}

      reporter = RubyCritic::CommandFactory.create(parsed_options)

      _(reporter).must_be_instance_of RubyCritic::Command::Version
    end

    context 'when mode has underscore' do
      it 'returns help command' do
        parsed_options = {mode: :help_text}

        reporter = RubyCritic::CommandFactory.create(parsed_options)

        _(reporter).must_be_instance_of RubyCritic::Command::Help
      end
    end

    context 'with invalid mode' do
      it 'returns default command' do
        parsed_options = {mode: :invalid}

        reporter = RubyCritic::CommandFactory.create(parsed_options)

        _(reporter).must_be_instance_of RubyCritic::Command::Default
      end
    end
  end
end
