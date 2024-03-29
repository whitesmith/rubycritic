# frozen_string_literal: true

module RubyCritic
  module ViewHelpers
    def timeago_tag(time)
      "<time class='js-timeago' datetime='#{time}'>#{time}</time>"
    end

    def asset_path(file)
      relative_path("assets/#{file}")
    end

    def file_path(file)
      relative_path(file)
    end

    def smell_location_path(location)
      smell_location = "#{location.pathname.sub_ext('.html')}#L#{location.line}"
      if Config.compare_branches_mode?
        file_path("#{File.expand_path(Config.feature_root_directory)}/#{smell_location}")
      else
        file_path(smell_location)
      end
    end

    def code_index_path(root_directory, file_name)
      root_directory_path = File.expand_path(root_directory)
      index_path = "#{root_directory_path}/#{file_name}"
      index_path = "#{root_directory_path}/overview.html" unless File.exist?(index_path)
      file_path(index_path)
    end

    private

    def relative_path(file)
      (root_directory + file).relative_path_from(file_directory)
    end

    def file_directory
      raise NotImplementedError,
            "The #{self.class} class must implement the #{__method__} method."
    end

    def root_directory
      raise NotImplementedError,
            "The #{self.class} class must implement the #{__method__} method."
    end
  end
end
