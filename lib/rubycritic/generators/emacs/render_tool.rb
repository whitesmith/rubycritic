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
          @analysed_modules.each do |analysed_module|
            analysed_module.smells.each do |smell|
              message = "[#{smell.status}] " # "status": "old",
              message << "#{smell.type} - " # "type": "DuplicateCode"
              message << "#{smell.context} " # "context": "Identical code",
              message << "#{smell.message}" # "message": "found in 2 nodes",
              smell.locations.each do |location|
                output.printf("%s:%d:%d: %s: %s\n", file, location, 0, "W", message)
              end
            end
          end
        end

      end
    end
  end
end
