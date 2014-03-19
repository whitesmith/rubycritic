require "erb"
require "rubycritic/report_generators/line_generator"

module Rubycritic

  class FileGenerator < BaseGenerator
    LINE_NUMBER_OFFSET = 1
    FILE_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "file.html.erb")))
    LAYOUT_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "layouts", "application.html.erb")))

    def initialize(pathname, smells)
      @pathname = pathname
      @smells = smells
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
  end

end
