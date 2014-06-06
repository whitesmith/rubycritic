require "pathname"

module Rubycritic

  module ViewHelpers
    def javascript_tag(file)
      "<script src='" + asset_path(File.join("javascripts", "#{file}.js")) + "'></script>"
    end

    def stylesheet_path(file)
      asset_path(File.join("stylesheets", "#{file}.css"))
    end

    def asset_path(file)
      File.join(root_directory, "assets", file)
    end

    def file_path(file)
      File.join(root_directory, Pathname(file).sub_ext(".html"))
    end

    def smell_location_path(location)
      File.join(root_directory, "#{location.pathname.sub_ext('.html')}#L#{location.line}")
    end

    def root_directory
      ::Rubycritic.configuration.root
    end
  end

end
