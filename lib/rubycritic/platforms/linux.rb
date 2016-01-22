require 'rubycritic/platforms/base'

module Rubycritic
  module Platforms
    class Linux < Base
      BROWSER_MAP = {}.tap do |hash|
        hash[:chrome] = 'google-chrome'
        hash[:chromium] = 'chromium-browser'
        hash[:firefox] = 'firefox'
        hash.default = 'firefox'
      end

      def can_open?
        platform == :linux || platform == :unix
      end

      def browser
        BROWSER_MAP[browser_name]
      end

      def application
        `which #{browser}`.chop
      end

      def open(report_path)
        system("#{application} #{report_path}")
      end
    end
  end
end
