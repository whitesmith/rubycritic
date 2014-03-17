require "test_helper"
require "rubycritic/source_locator"

describe Rubycritic::SourceLocator do
  before do
    @original_dir = Dir.pwd
    Dir.chdir("test/samples/location")
  end

  describe "#paths" do
    it "finds a single path" do
      paths = ["file0.rb"]
      Rubycritic::SourceLocator.new(paths).paths.must_equal paths
    end

    it "finds multiple paths" do
      paths = ["dir1/file1.rb", "file0.rb"]
      Rubycritic::SourceLocator.new(paths).paths.must_equal paths
    end

    it "finds all the paths" do
      paths = ["dir1/file1.rb", "file0.rb"]
      Rubycritic::SourceLocator.new(["."]).paths.must_equal paths
    end

    it "deals with non-existent paths" do
      paths = ["non_existent_dir1/non_existent_file1.rb", "non_existent_file0.rb"]
      Rubycritic::SourceLocator.new(paths).paths.must_equal []
    end
  end

  describe "#pathnames" do
    it "finds a single path" do
      path = "file0.rb"
      paths = [path]
      result = [Pathname.new(path)]
      Rubycritic::SourceLocator.new(paths).pathnames.must_equal result
    end
  end

  after do
    Dir.chdir(@original_dir)
  end
end
