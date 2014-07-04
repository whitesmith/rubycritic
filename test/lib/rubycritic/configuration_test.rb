require "test_helper"
require "rubycritic/configuration"

describe Rubycritic::Configuration do
  describe "#root" do
    before do
      @default = Rubycritic.configuration.root
    end

    it "has a default" do
      Rubycritic.configuration.root.wont_be_empty
    end

    it "can be set to a relative path" do
      Rubycritic.configuration.root = "foo"
      Rubycritic.configuration.root.must_equal File.expand_path("foo")
    end

    it "can be set to an absolute path" do
      Rubycritic.configuration.root = "/foo"
      Rubycritic.configuration.root.must_equal "/foo"
    end

    after do
      Rubycritic.configuration.root = @default
    end
  end
end
