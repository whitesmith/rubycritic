require "test_helper"
require "rubycritic/browser"
require "rubycritic/platforms/linux"
require "rubycritic/platforms/darwin"
require "rubycritic/generators/html_report"

describe Rubycritic::Browser do
  before do
    @report_path = "tmp/rubycritic/overview.html"
    @browser = Rubycritic::Browser.new @report_path
  end

  describe "open report on different platform" do
    context "on linux" do
      it "open with default browser" do
        Rubycritic::Config.set
        Rubycritic::Browser.any_instance.stubs(:platform).returns(Rubycritic::Platforms::Linux.new)
        @linux = @browser.platform
        @linux.browser.must_equal "firefox"
      end

      it "open with google chrome browser " do
        Rubycritic::Config.stubs(:open_with).returns(:chrome)
        Rubycritic::Browser.any_instance.stubs(:platform).returns(Rubycritic::Platforms::Linux.new)
        @linux = @browser.platform
        @linux.browser.must_equal "google-chrome"
      end

      it "open with chromium browser " do
        Rubycritic::Config.stubs(:open_with).returns(:chromium)
        Rubycritic::Browser.any_instance.stubs(:platform).returns(Rubycritic::Platforms::Linux.new)
        @linux = @browser.platform
        @linux.browser.must_equal "chromium-browser"
      end
    end

    context "on darwin" do
      it "open with default browser" do
        Rubycritic::Browser.any_instance.stubs(:platform).returns(Rubycritic::Platforms::Darwin.new)
        @darwin = @browser.platform
        @darwin.browser.must_equal "safari"
      end

      it "open with google chrome browser " do
        Rubycritic::Config.stubs(:open_with).returns(:chrome)
        Rubycritic::Browser.any_instance.stubs(:platform).returns(Rubycritic::Platforms::Darwin.new)
        @darwin = @browser.platform
        @darwin.browser.must_equal "Google Chrome"
      end

      it "open with firefox browser " do
        Rubycritic::Config.stubs(:open_with).returns(:firefox)
        Rubycritic::Browser.any_instance.stubs(:platform).returns(Rubycritic::Platforms::Darwin.new)
        @darwin = @browser.platform
        @darwin.browser.must_equal "firefox"
      end
    end

    context "on other platform" do
      it "not open with browser" do
        Rubycritic::Browser.any_instance.stubs(:platform).returns(nil)
        Rubycritic::Browser.any_instance.stubs(:report_path).returns("tmp/rubycritic/overview.html")
        @browser.open.must_be_nil
      end
    end
  end
end
