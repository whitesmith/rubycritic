require "test_helper"
require "rubycritic/configuration"

describe Rubycritic::Configuration do
  describe "#root" do
    before do
      Rubycritic::Config.set
      @default = Rubycritic::Config.root
    end

    it "has a default" do
      Rubycritic::Config.root.must_be_instance_of String
    end

    it "can be set to a relative path" do
      Rubycritic::Config.root = "foo"
      Rubycritic::Config.root.must_equal File.expand_path("foo")
    end

    it "can be set to an absolute path" do
      Rubycritic::Config.root = "/foo"
      Rubycritic::Config.root.must_equal "/foo"
    end

    after do
      Rubycritic::Config.root = @default
    end
  end
end
