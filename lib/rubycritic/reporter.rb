# frozen_string_literal: true

module RubyCritic
  module Reporter
    def self.generate_report(analysed_modules)
      report_generator_class.new(analysed_modules).generate_report
    end

    def self.report_generator_class
      case Config.format
      when :json
        require 'rubycritic/generators/json_report'
        Generator::JsonReport
      when :console
        require 'rubycritic/generators/console_report'
        Generator::ConsoleReport
      when :lint
        require 'rubycritic/generators/lint_report'
        Generator::LintReport
      else
        require 'rubycritic/generators/html_report'
        Generator::HtmlReport
      end
    end
  end
end
