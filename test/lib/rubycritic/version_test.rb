require "test_helper"

describe "Rubycritic version" do
  it "is defined" do
    Rubycritic::VERSION.wont_be_nil
  end
end
