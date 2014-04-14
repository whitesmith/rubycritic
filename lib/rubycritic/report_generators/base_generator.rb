require "rubycritic/report_generators/view_helpers"

module Rubycritic

  class BaseGenerator
    REPORT_DIR = File.expand_path("tmp/rubycritic", Dir.getwd)
    TEMPLATES_DIR = File.expand_path("../templates", __FILE__)

    include ViewHelpers

    def file_href
      "file://#{file_pathname}"
    end

    def file_pathname
      File.join(file_directory, file_name)
    end

    def file_directory
      raise NotImplementedError.new("You must implement the file_directory method.")
    end

    def file_name
      raise NotImplementedError.new("You must implement the file_name method.")
    end

    def render
      raise NotImplementedError.new("You must implement the render method.")
    end

    def get_binding
      binding
    end

    private

    def root_directory
      REPORT_DIR
    end
  end

end
