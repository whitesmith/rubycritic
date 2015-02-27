require "erb"
require "rubycritic/generators/base"
require "rubycritic/generators/html/view_helpers"

module Rubycritic
  module Generator
    module Html

      class Base < Base
        def self.erb_template(template_path)
          ERB.new(File.read(File.join(TEMPLATES_DIR, template_path)))
        end

        TEMPLATES_DIR = File.expand_path("../templates", __FILE__)
        LAYOUT_TEMPLATE = erb_template(File.join("layouts", "application.html.erb"))

        include ViewHelpers

        private

        def get_binding
          binding
        end
      end

    end
  end
end
