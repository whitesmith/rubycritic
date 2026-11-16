# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/cli/application'

describe RubyCritic::Cli::Application do
  describe '#execute' do
    it 'returns STATUS_ERROR and prints the message when a RubyCritic::Error is raised' do
      RubyCritic::CommandFactory.stubs(:create).raises(RubyCritic::Error, 'something went wrong')
      application = RubyCritic::Cli::Application.new([])

      status = stderr = nil
      capture_output_streams do
        status = application.execute
        stderr = $stderr.string
      end

      _(status).must_equal RubyCritic::Cli::Application::STATUS_ERROR
      _(stderr).must_equal "Error: something went wrong\n"
    end
  end
end
