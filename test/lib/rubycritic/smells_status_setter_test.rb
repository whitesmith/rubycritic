require "test_helper"
require "rubycritic/smell"
require "rubycritic/smells_status_setter"

describe Rubycritic::SmellsStatusSetter do
  describe "#smelly_pathnames" do
    before do
      @smell = Rubycritic::Smell.new(:context => "#bar")
      @smelly_pathnames = { "file0.rb" => [@smell] }
    end

    it "marks old smells" do
      Rubycritic::SmellsStatusSetter.new(@smelly_pathnames, @smelly_pathnames).smelly_pathnames
      @smell.status.must_equal :old
    end

    it "marks new smells" do
      Rubycritic::SmellsStatusSetter.new({}, @smelly_pathnames).smelly_pathnames
      @smell.status.must_equal :new
    end
  end
end
