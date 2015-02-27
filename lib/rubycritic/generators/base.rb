require "pathname"

module Rubycritic
  module Generator

    class Base
      def file_href
        "file://#{file_pathname}"
      end

      def file_pathname
        File.join(file_directory, file_name)
      end

      def file_directory
        @file_directory ||= root_directory
      end

      def file_name
        raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
      end

      def render
        raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
      end

      private

      def root_directory
        @root_directory ||= Pathname.new(Config.root)
      end
    end

  end
end
