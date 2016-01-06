require "json"

module Rubycritic
  module Generator
    module Emacs

      class RenderTool
        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
        end

        # render outputs the report in a format that's
        # easy to read in the Emacs and Sublime text editor.
        def render
          render_lines = []
          @analysed_modules.map do |analysed_module|
            analysed_module.smells.map do |smell|
              message = "[#{smell.status}] " # "status": "old",
              message << "#{smell.type} - " # "type": "DuplicateCode"
              message << "#{smell.context} " # "context": "Identical code",
              message << "#{smell.message}" # "message": "found in 2 nodes",
              smell.locations.map do |location|
                render_lines << "#{location.to_s_with_realpath}:1: W: #{message}"
              end
            end
          end
          render_lines << ""
          render_lines.join("\n")
        end

      end
    end
  end
end
