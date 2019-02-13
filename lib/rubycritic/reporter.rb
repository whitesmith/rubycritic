# frozen_string_literal: true

module RubyCritic
  module Reporter
    REPORT_GENERATOR_CLASS_FORMATS = %i[json console lint].freeze

    def self.generate_report(analysed_modules)
      Config.formats.uniq.each do |format|
        report_generator_class(format).new(analysed_modules).generate_report
      end
    end

    def self.report_generator_class(config_format)
      if REPORT_GENERATOR_CLASS_FORMATS.include? config_format
        require "rubycritic/generators/#{config_format}_report"
        Generator.const_get("#{config_format.capitalize}Report")
      else
        require 'rubycritic/generators/html_report'
        Generator::HtmlReport
      end
    end
  end
end
