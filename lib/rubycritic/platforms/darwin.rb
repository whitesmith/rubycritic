require "rubycritic/platforms/base"

module Rubycritic
  module Platforms
    class Darwin < Base
      BROWSER_MAP = {}.tap do |hash|
        hash.merge! :chrome => "Google Chrome", :firefox => "firefox", :safari => "safari"
        hash.default = "safari"
      end

      def can_open?
        platform == :darwin
      end

      def application
        BROWSER_MAP[browser_name]
      end
      alias_method :browser, :application

      def open(report_path)
        system("open -a '#{application}' #{report_path}")
      end
    end

  end
end
