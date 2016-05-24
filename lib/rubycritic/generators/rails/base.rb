require 'erb'
require 'pathname'
require 'rubycritic/generators/html/base'
require 'rubycritic/generators/rails/view_helpers'

module Rubycritic
  module Generator
    module Rails
      class Base < Rubycritic::Generator::Html::Base

        TEMPLATES_DIR = File.expand_path('../../html/templates', __FILE__)

        private

        def root_directory
          @root_directory ||= Pathname.new(Config.root) + 'app/views/rubycritic'
        end

      end
    end
  end
end
