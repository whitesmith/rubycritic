module Rubycritic
  module Config
    class Base
      attr_reader :root
      attr_accessor :source_control_system, :mode, :format, :deduplicate_symlinks,
                    :suppress_ratings, :open_with, :no_browser

      def set(options)
        self.mode = options[:mode] || :default
        self.root = options[:root] || 'tmp/rubycritic'
        self.format = options[:format] || :html
        self.deduplicate_symlinks = options[:deduplicate_symlinks] || false
        self.suppress_ratings = options[:suppress_ratings] || false
        self.open_with = options[:open_with]
        self.no_browser = options[:no_browser]
      end

      def root=(path)
        @root = File.expand_path(path)
      end

    end
  end
end