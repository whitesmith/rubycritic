require 'rexml/document'

module Rubycritic
  module Generator
    module Xml
      class Simple
        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
        end

        def render
          "".tap { |result| document.write(output: result, indent: 2) }
        end

        private

        def document
          REXML::Document.new.tap do |document|
            document << REXML::XMLDecl.new << checkstyle
          end
        end

        def checkstyle
          REXML::Element.new('checkstyle').tap do |checkstyle|
            @analysed_modules.each do |analysed_module|
              if (analysed_module.smells.size > 0)
                checkstyle << file(analysed_module.path, analysed_module.smells)
              end
            end
          end
        end

        def file(name, smells)
          REXML::Element.new('file').tap do |file|
            file.add_attribute 'name', File.realpath(name)
            smells.each do |smell|
              smell.locations.each do |location|
                file << error(smell, location.line)
              end
            end
          end
        end

        def error(smell, line)
          REXML::Element.new('error').tap do |error|
            error.add_attributes 'column' => 0,
              'line'     => line,
              'message'  => smell.message,
              'severity' => 'warning',
              'source'   => smell.type
          end
        end
      end
    end
  end
end
