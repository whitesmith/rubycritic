# frozen_string_literal: true

require 'erb'
module RubyCritic
  module Generator
    module Text
      class Lint
        class << self
          TEMPLATE_PATH = File.expand_path('templates/lint.erb', __dir__)
          FILE_NAME = 'lint.txt'.freeze

          def file_directory
            @file_directory ||= Pathname.new(Config.root)
          end

          def file_pathname
            Pathname.new(file_directory).join FILE_NAME
          end

          def erb_template
            @erb_template ||= ERB.new(File.read(TEMPLATE_PATH), nil, '-')
          end
        end

        def initialize(analysed_module)
          @analysed_module = analysed_module
        end

        def render
          erb_template.result(binding)
        end

        private

        def erb_template
          self.class.erb_template
        end
      end
    end
  end
end
