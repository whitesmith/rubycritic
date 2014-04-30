require "erb"
require "rubycritic/report_generators/view_helpers"

module Rubycritic

  class BaseGenerator
    REPORT_DIR = File.expand_path("tmp/rubycritic", Dir.getwd)
    TEMPLATES_DIR = File.expand_path("../templates", __FILE__)
    LAYOUT_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "layouts", "application.html.erb")))

    include ViewHelpers

    def file_href
      "file://#{file_pathname}"
    end

    def file_pathname
      File.join(file_directory, file_name)
    end

    def file_directory
      root_directory
    end

    def file_name
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end

    def render
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
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
