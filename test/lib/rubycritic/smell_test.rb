require "test_helper"
require "rubycritic/smell"

describe Rubycritic::Smell do
  it "has a context reader" do
    context = "#bar"
    smell = Rubycritic::Smell.new(:context => context)
    smell.context.must_equal context
  end

  it "has a locations reader" do
    location = Rubycritic::Location.new("./foo", "42")
    smell = Rubycritic::Smell.new(:locations => [location])
    smell.locations.must_equal [location]
  end

  it "has a pathnames reader" do
    path = Pathname.new("./foo")
    location1 = Rubycritic::Location.new("./foo", "42")
    location2 = Rubycritic::Location.new("./foo", "23")
    smell = Rubycritic::Smell.new(:locations => [location1, location2])
    smell.pathnames.must_equal [path]
  end

  it "has a message reader" do
    message = "This smells"
    smell = Rubycritic::Smell.new(:message => message)
    smell.message.must_equal message
  end

  it "has a score reader" do
    score = 0
    smell = Rubycritic::Smell.new(:score => score)
    smell.score.must_equal score
  end

  it "has a type reader" do
    type = :complexity
    smell = Rubycritic::Smell.new(:type => type)
    smell.type.must_equal type
  end

  it "is sortable" do
    location1 = Rubycritic::Location.new("./foo", 42)
    location2 = Rubycritic::Location.new("./bar", 23)
    location3 = Rubycritic::Location.new("./bar", 16)
    [location1, location2, location3].sort.must_equal [location3, location2, location1]
  end

  describe "#located_in?" do
    it "returns true if the smell has a location that matches the location passed as argument" do
      location = Rubycritic::Location.new("./foo", "42")
      smell = Rubycritic::Smell.new(:locations => [location])
      smell.located_in?(location).must_equal true
    end
  end
end
