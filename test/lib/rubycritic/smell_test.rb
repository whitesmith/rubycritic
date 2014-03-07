require "test_helper"
require "rubycritic/smell"

describe Rubycritic::Smell do
  before do
    @location = "./foo:42"
    @context = "#bar"
    @score = 0
    @smell = Rubycritic::Smell.new(:metric => :abc, :location => @location, :context => @context, :score => @score)
  end

  it "has a context reader" do
    @smell.context.must_equal @context
  end

  it "has a location reader" do
    @smell.location.must_equal @location
  end

  it "has a score reader" do
    @smell.score.must_equal @score
  end
end
