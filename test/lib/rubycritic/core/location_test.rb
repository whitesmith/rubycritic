require "test_helper"
require "rubycritic/core/location"

describe Rubycritic::Location do
  describe "attribute readers" do
    before do
      @path = "./foo.rb"
      @line = "42"
      @location = Rubycritic::Location.new(@path, @line)
    end

    it "has a pathname" do
      @location.pathname.must_equal Pathname.new(@path)
    end

    it "has a line number" do
      @location.line.must_equal @line.to_i
    end

    it "has a file name" do
      @location.file_name.must_equal "foo"
    end
  end

  it "is comparable" do
    location1 = Rubycritic::Location.new("./foo", 42)
    location2 = Rubycritic::Location.new("./foo", 42)
    location1.must_equal location2
  end

  it "is sortable" do
    location1 = Rubycritic::Location.new("./foo", 42)
    location2 = Rubycritic::Location.new("./bar", 23)
    location3 = Rubycritic::Location.new("./bar", 16)
    [location1, location2, location3].sort.must_equal [location3, location2, location1]
  end
end
