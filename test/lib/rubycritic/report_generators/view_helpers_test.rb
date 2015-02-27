require "test_helper"
require "rubycritic/generators/html/view_helpers"
require "pathname"

describe Rubycritic::ViewHelpers do
  context "when the file is in the root directory" do
    let(:generator) { GeneratorDouble.new("foo.html") }

    describe "#file_path" do
      context "when the other file is in the same directory" do
        it "creates a relative path to a file" do
          generator.file_path("bar.html").to_s.must_equal "bar.html"
        end
      end

      context "when the other file is in a subdirectory" do
        it "creates a relative path to a file" do
          generator.file_path("subdirectory/bar.html").to_s.must_equal "subdirectory/bar.html"
        end
      end
    end

    describe "#asset_path" do
      it "creates a relative path to an asset" do
        generator.asset_path("stylesheets/application.css").to_s
          .must_equal "assets/stylesheets/application.css"
      end
    end
  end

  context "when the file is n directories deep" do
    let(:generator) { GeneratorDouble.new("lets/go/crazy/foo.html") }

    describe "#file_path" do
      context "when the other file is in the same directory" do
        it "creates a relative path to a file" do
          generator.file_path("lets/go/crazy/bar.html").to_s.must_equal "bar.html"
        end
      end

      context "when the other file is in the root directory" do
        it "creates a relative path to a file" do
          generator.file_path("bar.html").to_s.must_equal "../../../bar.html"
        end
      end

      context "when the other file has n-1 directories in common" do
        it "creates a relative path to a file" do
          generator.file_path("lets/go/home/bar.html").to_s.must_equal "../home/bar.html"
        end
      end

      context "when the other file is one directory deeper" do
        it "creates a relative path to a file" do
          generator.file_path("lets/go/crazy/everybody/bar.html").to_s.must_equal "everybody/bar.html"
        end
      end
    end

    describe "#asset_path" do
      it "creates a relative path to an asset" do
        generator.asset_path("stylesheets/application.css").to_s
          .must_equal "../../../assets/stylesheets/application.css"
      end
    end
  end
end

class GeneratorDouble
  include Rubycritic::ViewHelpers

  def initialize(file)
    @file = Pathname.new(file)
  end

  def file_directory
    root_directory + @file.dirname
  end

  def root_directory
    Pathname.new("root_directory")
  end
end
