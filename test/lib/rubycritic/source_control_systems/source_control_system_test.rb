require "test_helper"
require "rubycritic/source_control_systems/source_control_system"

describe Rubycritic::SourceControlSystem do
  before do
    Rubycritic::SourceControlSystem.systems.each do |system|
      system.stubs(:supported?).returns(false)
    end
  end

  describe "::create" do
    describe "when a source control system is found" do
      it "creates an instance of that source control system" do
        Rubycritic::Git.stubs(:supported?).returns(true)
        system = Rubycritic::SourceControlSystem.create
        system.must_be_instance_of Rubycritic::Git
      end
    end

    describe "when no source control system is found" do
      it "raises an error" do
        proc { Rubycritic::SourceControlSystem.create }.must_raise RuntimeError
      end
    end
  end
end
