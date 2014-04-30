require "test_helper"
require "rubycritic/source_locator"

describe Rubycritic::SourceLocator do
  before do
    @original_dir = Dir.getwd
    Dir.chdir("test/samples/location")
  end

  describe "#paths" do
    it "finds a single file" do
      paths = ["file0.rb"]
      Rubycritic::SourceLocator.new(paths).paths.must_equal paths
    end

    it "finds files through multiple paths" do
      paths = ["dir1/file1.rb", "file0.rb"]
      Rubycritic::SourceLocator.new(paths).paths.must_equal paths
    end

    it "finds all the files inside a given directory" do
      initial_paths = ["dir1"]
      final_paths = ["dir1/file1.rb"]
      Rubycritic::SourceLocator.new(initial_paths).paths.must_equal final_paths
    end

    it "finds all the files" do
      initial_paths = ["."]
      final_paths = ["dir1/file1.rb", "file0.rb"]
      Rubycritic::SourceLocator.new(initial_paths).paths.must_equal final_paths
    end

    it "cleans paths of consecutive slashes and useless dots" do
      initial_paths = [".//file0.rb"]
      final_paths = ["file0.rb"]
      Rubycritic::SourceLocator.new(initial_paths).paths.must_equal final_paths
    end

    it "ignores paths to non-existent files" do
      initial_paths = ["non_existent_dir1/non_existent_file1.rb", "non_existent_file0.rb"]
      final_paths = []
      Rubycritic::SourceLocator.new(initial_paths).paths.must_equal final_paths
    end

    it "ignores paths to files that do not match the Ruby extension" do
      initial_paths = ["file_with_no_extension", "file_with_different_extension.py"]
      final_paths = []
      Rubycritic::SourceLocator.new(initial_paths).paths.must_equal final_paths
    end
  end

  describe "#pathnames" do
    it "finds a single file" do
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
