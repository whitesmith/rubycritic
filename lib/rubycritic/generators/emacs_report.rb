require "rubycritic/generators/emacs/render_tool"

module Rubycritic
  module Generator

    class EmacsReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        print generator.render
      end

      private

      def generator
        Emacs::RenderTool.new(@analysed_modules)
      end
    end

  end
end
