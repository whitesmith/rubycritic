require "test_helper"
require "rubycritic/configuration"

describe Rubycritic::Configuration do
  describe "#root" do
    it "has a default" do
      Rubycritic.configuration.root.wont_be_empty
    end

    it "can be configured" do
      default = Rubycritic.configuration.root
      Rubycritic.configuration.root = "foo"
      Rubycritic.configuration.root.must_equal File.expand_path("foo")
      Rubycritic.configuration.root = default
    end
  end
end
