require "test_helper"
require "rubycritic/smell"

describe Rubycritic::Smell do
  before do
    @locations = ["./foo:42"]
    @context = "#bar"
    @score = 0
    @smell = Rubycritic::Smell.new(:metric => :abc, :locations => @locations, :context => @context, :score => @score)
  end

  it "has a context reader" do
    @smell.context.must_equal @context
  end

  it "has a locations reader" do
    @smell.locations.must_equal @locations
  end

  it "has a score reader" do
    @smell.score.must_equal @score
  end
end
