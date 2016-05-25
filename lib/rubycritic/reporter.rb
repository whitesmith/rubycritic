module Rubycritic
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
      when :rails
        require 'rubycritic/generators/rails_report'
        Generator::RailsReport
      else
        require 'rubycritic/generators/html_report'
        Generator::HtmlReport
      end
    end
  end
end
