require "test_helper"
require "rubycritic/core/smell"
require "rubycritic/smells_status_setter"

describe Rubycritic::SmellsStatusSetter do
  describe "::smells" do
    before do
      @smell = Rubycritic::Smell.new(:context => "#bar")
      @smells = [@smell]
    end

    it "marks old smells" do
      Rubycritic::SmellsStatusSetter.set(@smells, @smells)
      @smell.status.must_equal :old
    end

    it "marks new smells" do
      Rubycritic::SmellsStatusSetter.set([], @smells)
      @smell.status.must_equal :new
    end
  end
end
