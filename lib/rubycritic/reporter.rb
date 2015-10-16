module Rubycritic

  module Reporter
    def self.generate_report(analysed_modules)
      report_generator_class.new(analysed_modules).generate_report
    end

    def self.report_generator_class
      case Config.format
      when :json
        require "rubycritic/generators/json_report"
        Generator::JsonReport
      when :emacs
        require "rubycritic/generators/emacs_report"
        Generator::EmacsReport
      else
        require "rubycritic/generators/html_report"
        Generator::HtmlReport
      end
    end
  end

end
