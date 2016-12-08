# frozen_string_literal: true
module RubyCritic
  module Colorize
    def colorize(text, color_code)
      "\e[#{color_code}m#{text}\e[0m"
    end

    def style(text, style_code)
      "\e[1m#{text}\e[#{style_code}m"
    end

    def red(text)
      colorize(text, 31)
    end

    def green(text)
      colorize(text, 32)
    end

    def bold(text)
      style(text, 22)
    end
  end
end
