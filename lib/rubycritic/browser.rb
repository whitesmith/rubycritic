require "rubycritic/platforms/linux"
require "rubycritic/platforms/darwin"

module Rubycritic
  class Browser
    attr_reader :report_path

    SUPPORTS = Platforms::Linux::BROWSER_MAP.keys | Platforms::Darwin::BROWSER_MAP.keys

    def initialize(report_path)
      @report_path = report_path
    end

    def open
      platform && platform.open(report_path)
    end

    def platform
      @platform ||= [Platforms::Linux.new, Platforms::Darwin.new].select(&:can_open?).first
    end
  end
end
