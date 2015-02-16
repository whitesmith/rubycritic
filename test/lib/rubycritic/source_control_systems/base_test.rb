require "test_helper"
require "rubycritic/source_control_systems/base"

describe Rubycritic::SourceControlSystem::Base do
  before do
    Rubycritic::SourceControlSystem::Base.systems.each do |system|
      system.stubs(:supported?).returns(false)
    end
  end

  describe "::create" do
    context "when a source control system is found" do
      it "creates an instance of that source control system" do
        Rubycritic::SourceControlSystem::Git.stubs(:supported?).returns(true)
        system = Rubycritic::SourceControlSystem::Base.create
        system.must_be_instance_of Rubycritic::SourceControlSystem::Git
      end
    end

    context "when no source control system is found" do
      it "creates a source control system double" do
        capture_output_streams do
          system = Rubycritic::SourceControlSystem::Base.create
          system.must_be_instance_of Rubycritic::SourceControlSystem::Double
        end
      end
    end
  end
end
