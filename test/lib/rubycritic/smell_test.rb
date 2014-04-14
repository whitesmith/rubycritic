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

  describe "#located_in?" do
    it "returns true if the smell has a location that matches the location passed as argument" do
      location = Rubycritic::Location.new("./foo", "42")
      smell = Rubycritic::Smell.new(:locations => [location])
      smell.located_in?(location).must_equal true
    end
  end

  describe "#has_multiple_locations?" do
    it "returns true if the smell has more than one location" do
      location1 = Rubycritic::Location.new("./foo", "42")
      location2 = Rubycritic::Location.new("./foo", "23")
      smell = Rubycritic::Smell.new(:locations => [location1, location2])
      smell.has_multiple_locations?.must_equal true
    end
  end

  it "is comparable" do
    attributes = {
      :context => "#bar",
      :message => "This smells",
      :score => 0,
      :type => :complexity
    }
    smell1 = Rubycritic::Smell.new(attributes)
    smell2 = Rubycritic::Smell.new(attributes)
    smell1.must_equal smell2
  end
end
