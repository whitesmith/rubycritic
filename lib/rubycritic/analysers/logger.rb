require 'ruby-progressbar'
require 'rubycritic/colorize'

module RubyCritic
  module Analyser
    class Logger
      include Colorize

      def initialize(total)
        @progress_bar = ProgressBar.create(title: 'Initializing', total: total, format: "%t: |%w[%c/%C]>>%i| #{bold('%a %e')}")
      end

      def topic=(topic)
        @progress_bar.title = "Running #{bold(topic)}"
      end

      def report_completion(completed_items=1)
        @progress_bar.progress += completed_items
      end
    end
  end
end
