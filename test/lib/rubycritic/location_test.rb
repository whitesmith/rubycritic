require "test_helper"
require "rubycritic/location"

describe Rubycritic::Location do
  describe "attribute readers" do
    before do
      @path = "./foo"
      @line = 42
      @location = Rubycritic::Location.new(@path, @line)
    end

    it "has a file path" do
      @location.path.must_equal @path
    end

    it "has a file name" do
      @location.file.must_equal "foo"
    end

    it "has a line number" do
      @location.line.must_equal @line
    end
  end

  it "is sortable" do
    location1 = Rubycritic::Location.new("./foo", 42)
    location2 = Rubycritic::Location.new("./bar", 23)
    location3 = Rubycritic::Location.new("./bar", 16)
    [location1, location2, location3].sort.must_equal [location3, location2, location1]
  end
end
