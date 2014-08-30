require "test_helper"
require "rubycritic/source_control_systems/base"
require_relative "interfaces/basic"

class DoubleTest < Minitest::Test
  include BasicInterface

  def setup
    @system = Rubycritic::SourceControlSystem::Double.new
  end
end
