# frozen_string_literal: true

require 'launchy'

module RubyCritic
  class Browser
    attr_reader :report_path

    def initialize(report_path)
      @report_path = report_path
    end

    def open
      Launchy.open(report_path) do |exception|
        puts "Attempted to open #{report_path} and failed because #{exception}"
      end
    end
  end
end
