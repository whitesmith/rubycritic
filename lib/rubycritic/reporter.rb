# frozen_string_literal: true

module RubyCritic
  module Reporter
    REPORT_GENERATOR_CLASS_FORMATS = %i[json console lint].freeze

    def self.generate_report(analysed_modules)
      RubyCritic::Config.formats.uniq.each do |format|
        report_generator_class(format).new(analysed_modules).generate_report
      end
      RubyCritic::Config.formatters.each do |formatter|
        report_generator_class_from_formatter(formatter).new(analysed_modules).generate_report
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

    def self.report_generator_class_from_formatter(formatter)
      require_path, class_name = formatter.sub(/([^:]):([^:])/, '\1\;\2').split('\;', 2)
      class_name ||= require_path
      require require_path unless require_path == class_name
      class_from_path(class_name)
    end

    def self.class_from_path(path)
      path.split('::').inject(Object) { |obj, klass| obj.const_get klass }
    rescue NameError => error
      raise "Could not create reporter for class #{path}. Error: #{error}!"
    end
  end
end
