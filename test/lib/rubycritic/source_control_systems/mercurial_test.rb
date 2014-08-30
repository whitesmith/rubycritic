require "test_helper"
require "rubycritic/source_control_systems/base"
require_relative "interfaces/basic"

class MercurialTest < Minitest::Test
  include BasicInterface

  def setup
    @system = Rubycritic::SourceControlSystem::Mercurial.new
  end
end
