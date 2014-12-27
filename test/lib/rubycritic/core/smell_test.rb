require "test_helper"
require "rubycritic/core/smell"

describe Rubycritic::Smell do
  describe "attribute readers" do
    before do
      @locations = [Rubycritic::Location.new("./foo", "42")]
      @context = "#bar"
      @message = "This smells"
      @score = 0
      @type = :complexity
      @smell = Rubycritic::Smell.new(
        :locations => @locations,
        :context   => @context,
        :message   => @message,
        :score     => @score,
        :type      => @type
      )
    end

    it "has a context reader" do
      @smell.context.must_equal @context
    end

    it "has a locations reader" do
      @smell.locations.must_equal @locations
    end

    it "has a message reader" do
      @smell.message.must_equal @message
    end

    it "has a score reader" do
      @smell.score.must_equal @score
    end

    it "has a type reader" do
      @smell.type.must_equal @type
    end
  end

  describe "#at_location?" do
    it "returns true if the smell has a location that matches the location passed as argument" do
      location = Rubycritic::Location.new("./foo", "42")
      smell = Rubycritic::Smell.new(:locations => [location])
      smell.at_location?(location).must_equal true
    end
  end

  describe "#multiple_locations?" do
    it "returns true if the smell has more than one location" do
      location1 = Rubycritic::Location.new("./foo", "42")
      location2 = Rubycritic::Location.new("./foo", "23")
      smell = Rubycritic::Smell.new(:locations => [location1, location2])
      smell.multiple_locations?.must_equal true
    end
  end

  describe "#==" do
    it "returns true if two smells have the same base attributes" do
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
end
