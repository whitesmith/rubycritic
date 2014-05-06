require "erb"
require "rubycritic/report_generators/base_generator"
require "rubycritic/report_generators/line_generator"

module Rubycritic

  class FileGenerator < BaseGenerator
    LINE_NUMBER_OFFSET = 1
    TEMPLATE = erb_template("file.html.erb")

    def initialize(pathname, smells)
      @pathname = pathname
      @smells = smells
    end

    def file_directory
      File.join(root_directory, @pathname.dirname)
    end

    def file_name
      "#{analysed_file_name}.html"
    end

    def analysed_file_name
      @pathname.basename.sub_ext("")
    end

    def render
      file_code = ""
      File.readlines(@pathname).each.with_index(LINE_NUMBER_OFFSET) do |line_text, line_number|
        location = Location.new(@pathname, line_number)
        line_smells = @smells.select { |smell| smell.located_in?(location) }
        file_code << LineGenerator.new(line_text, line_smells).render
      end

      file_body = TEMPLATE.result(get_binding { file_code })
      LAYOUT_TEMPLATE.result(get_binding { file_body })
    end

    def file_has_smells?
      !@smells.empty?
    end
  end

end
