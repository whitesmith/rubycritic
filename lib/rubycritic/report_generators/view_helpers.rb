require "pathname"

module Rubycritic

  module ViewHelpers
    def timeago_tag(time)
      "<time class='js-timeago' datetime='#{time}'>#{time}</time>"
    end

    def javascript_tag(file)
      "<script src='" + asset_path("javascripts", "#{file}.js").to_s + "'></script>"
    end

    def stylesheet_path(file)
      asset_path("stylesheets", "#{file}.css")
    end

    def asset_path(*fragments)
      ([root_directory, "assets"] + fragments).reduce(:+)
    end

    def file_path(file)
      root_directory + file
    end

    def smell_location_path(location)
      root_directory + "#{location.pathname.sub_ext('.html')}#L#{location.line}"
    end

    private

    def root_directory
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end
  end

end
