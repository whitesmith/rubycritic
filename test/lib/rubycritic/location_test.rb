require "test_helper"
require "rubycritic/location"

describe Rubycritic::Location do
  before do
    @path = "./foo"
    @line = 42
    @location = Rubycritic::Location.new(@path, @line)
  end

  it "has a file pathname" do
    @location.path.must_equal @path
  end

  it "has a file name" do
    @location.file.must_equal "foo"
  end

  it "has a line number" do
    @location.line.must_equal @line
  end
end
