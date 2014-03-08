require "test_helper"
require "rubycritic/smell"

describe Rubycritic::Smell do
  before do
    @locations = ["./foo:42"]
    @context = "#bar"
    @message = "This smells"
    @score = 0
    @type = :complexity
    @smell = Rubycritic::Smell.new(
      :locations => @locations,
      :context => @context,
      :message => @message,
      :score => @score,
      :type => @type
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
