module Rubycritic

  module ViewHelpers
    def javascript_path(file)
      asset_path(File.join("javascripts", "#{file}.js"))
    end

    def stylesheet_path(file)
      asset_path(File.join("stylesheets", "#{file}.css"))
    end

    def asset_path(file)
      File.join(root_directory, "assets", file)
    end

    def smell_location_path(location)
      pathname = location.pathname
      File.join(root_directory, "#{pathname.sub_ext('.html')}#L#{location.line}")
    end

    def index_path
      File.join(root_directory, "index.html")
    end
  end

end
