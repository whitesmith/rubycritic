# frozen_string_literal: true

module RubyCritic
  module Reporter
    REPORT_GENERATOR_CLASS_FORMATS = %i[json console lint].freeze

    def self.generate_report(analysed_modules, format)
      report_generator_class(format).new(analysed_modules).generate_report
    end

    def self.report_generator_class(format)
      if REPORT_GENERATOR_CLASS_FORMATS.include? format
        require "rubycritic/generators/#{format}_report"
        Generator.const_get("#{format.capitalize}Report")
      else
        require 'rubycritic/generators/html_report'
        Generator::HtmlReport
      end
    end
  end
end
