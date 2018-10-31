# frozen_string_literal: true

require 'erb'
require 'pathname'
require 'rubycritic/generators/html/view_helpers'

module RubyCritic
  module Generator
    module Html
      class Base
        def self.erb_template(template_path)
          ERB.new(File.read(File.join(TEMPLATES_DIR, template_path)))
        end

        TEMPLATES_DIR = File.expand_path('templates', __dir__)
        LAYOUT_TEMPLATE = erb_template(File.join('layouts', 'application.html.erb'))

        include ViewHelpers

        def file_href
          "file:///#{file_pathname}"
        end

        def file_pathname
          File.join(file_directory, file_name)
        end

        def file_directory
          @file_directory ||= root_directory
        end

        def file_name
          raise NotImplementedError,
                "The #{self.class} class must implement the #{__method__} method."
        end

        def render
          raise NotImplementedError,
                "The #{self.class} class must implement the #{__method__} method."
        end

        private

        def root_directory
          @root_directory ||= Pathname.new(Config.root)
        end

        def base_binding
          binding
        end
      end
    end
  end
end
