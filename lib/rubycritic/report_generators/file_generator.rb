require "erb"
require "rubycritic/report_generators/line_generator"

module Rubycritic

  class FileGenerator
    LINE_NUMBER_OFFSET = 1
    REPORT_DIR = File.expand_path("tmp/rubycritic", Dir.getwd)
    TEMPLATES_DIR = File.expand_path("../templates", __FILE__)
    FILE_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "file.html.erb")))
    LAYOUT_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "layouts", "application.html.erb")))

    def initialize(pathname, smells)
      @pathname = pathname
      @smells = smells
    end

    def file_pathname
      File.join(file_directory, file_name)
    end

    def file_directory
      File.join(REPORT_DIR, File.dirname(@pathname))
    end

    def file_name
      "#{analysed_file_name}.html"
    end

    def analysed_file_name
      @pathname.basename.sub_ext('').to_s
    end

    def render
      file_code = ""
      File.readlines(@pathname).each.with_index(LINE_NUMBER_OFFSET) do |line_text, line_number|
        location = Location.new(@pathname, line_number)
        line_smells = @smells.select { |smell| smell.located_in?(location) }
        file_code << LineGenerator.new(line_text, line_number, line_smells).render
      end

      file_body = FILE_TEMPLATE.result(self.get_binding { file_code })

      LAYOUT_TEMPLATE.result(self.get_binding { file_body })
    end

    def stylesheet_path
      File.join(REPORT_DIR, "assets/stylesheets/application.css")
    end

    def get_binding
      binding
    end
  end

end
