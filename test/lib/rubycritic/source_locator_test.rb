require "test_helper"
require "rubycritic/source_locator"

describe Rubycritic::SourceLocator do
  before do
    @original_dir = Dir.pwd
    Dir.chdir("test/samples/location")
  end

  it "finds a single file" do
    file = ["file0.rb"]
    Rubycritic::SourceLocator.new(file).source_files.must_equal file
  end

  it "finds multiple files" do
    files = ["dir1/file1.rb", "file0.rb"]
    Rubycritic::SourceLocator.new(files).source_files.must_equal files
  end

  it "finds all the files" do
    files = ["dir1/file1.rb", "file0.rb"]
    Rubycritic::SourceLocator.new(["."]).source_files.must_equal files
  end

  after do
    Dir.chdir(@original_dir)
  end
end
