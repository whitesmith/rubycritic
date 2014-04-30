require "test_helper"
require "rubycritic/configuration"

describe Rubycritic::Configuration do
  describe "#root" do
    it "has a default" do
      Rubycritic.configuration.root.wont_be_empty
    end
  end
end
