require "test_helper"
require "rubycritic/source_control_systems/base"

describe Rubycritic::SourceControlSystem do
  before do
    Rubycritic::SourceControlSystem::Base.systems.each do |system|
      system.stubs(:supported?).returns(false)
    end
  end

  describe "::create" do
    describe "when a source control system is found" do
      it "creates an instance of that source control system" do
        Rubycritic::SourceControlSystem::Git.stubs(:supported?).returns(true)
        system = Rubycritic::SourceControlSystem::Base.create
        system.must_be_instance_of Rubycritic::SourceControlSystem::Git
      end
    end
  end
end
