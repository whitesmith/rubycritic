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

    it "finds all the files inside a given directory" do
      initial_paths = ["dir1"]
      final_paths = ["dir1/file1.rb"]
      Rubycritic::SourceLocator.new(initial_paths).paths.must_equal final_paths
    end

    it "finds files through multiple paths" do
      paths = ["dir1/file1.rb", "file0.rb"]
      Rubycritic::SourceLocator.new(paths).paths.must_match_array paths
    end

    it "finds all the files" do
      initial_paths = ["."]
      final_paths = ["dir1/file1.rb", "file0.rb", "file0_symlink.rb"]
      Rubycritic::SourceLocator.new(initial_paths).paths.must_match_array final_paths
    end

    context "when configured to deduplicate symlinks" do
      it "favors a file over a symlink if they both point to the same target" do
        Rubycritic::Config.stubs(:deduplicate_symlinks).returns(true)
        initial_paths = ["file0.rb", "file0_symlink.rb"]
        final_paths = ["file0.rb"]
        Rubycritic::SourceLocator.new(initial_paths).paths.must_match_array final_paths
      end
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

    it "can deal with nil paths" do
      paths = nil
      final_paths = []
      Rubycritic::SourceLocator.new(paths).paths.must_equal final_paths
    end
  end

  describe "#pathnames" do
    it "finds a single file" do
      initial_paths = ["file0.rb"]
      final_pathnames = [Pathname.new("file0.rb")]
      Rubycritic::SourceLocator.new(initial_paths).pathnames.must_equal final_pathnames
    end
  end

  after do
    Dir.chdir(@original_dir)
  end
end
