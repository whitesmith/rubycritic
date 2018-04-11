# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/source_control_systems/base'
require_relative 'interfaces/basic'
require_relative 'interfaces/time_travel'

class GitTest < Minitest::Test
  include BasicInterface
  include TimeTravelInterface

  def setup
    @system = RubyCritic::SourceControlSystem::Git.new
  end
end
