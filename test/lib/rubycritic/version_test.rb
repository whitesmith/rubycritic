require "test_helper"
require "rubycritic/version"

describe "Rubycritic version" do
  it "is defined" do
    Rubycritic::VERSION.wont_be_nil
  end
end
