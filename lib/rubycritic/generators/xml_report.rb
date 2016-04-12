require 'rubycritic/generators/xml/simple'

module Rubycritic
  module Generator
    class XmlReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        report = generator.render

        File.write "#{ Config.root }/report.xml", report
        print report
      end

      private

      def generator
        Xml::Simple.new(@analysed_modules)
      end
    end
  end
end
