module Rubycritic

  class BaseGenerator
    REPORT_DIR = File.expand_path("tmp/rubycritic", Dir.getwd)
    TEMPLATES_DIR = File.expand_path("../templates", __FILE__)

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
      raise NotImplementedError.new("You must implement the render file_name method.")
    end

    def javascript_path(file)
      File.join(REPORT_DIR, "assets/javascripts/#{file}.js")
    end

    def stylesheet_path(file)
      File.join(REPORT_DIR, "assets/stylesheets/#{file}.css")
    end

    def index_path
      File.join(REPORT_DIR, "index.html")
    end

    def get_binding
      binding
    end
  end

end
