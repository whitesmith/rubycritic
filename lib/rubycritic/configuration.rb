module Rubycritic
  class Configuration
    attr_reader :root
    attr_accessor :source_control_system, :mode, :format, :deduplicate_symlinks,
                  :suppress_ratings, :open_with, :no_browser, :assets_folder,
                  :javascripts_path, :stylesheets_path, :for_rails

    def set(options)
      self.mode = options[:mode] || :default
      self.root = options[:root] || 'tmp/rubycritic'
      self.format = options[:format] || :html
      self.deduplicate_symlinks = options[:deduplicate_symlinks] || false
      self.suppress_ratings = options[:suppress_ratings] || false
      self.open_with = options[:open_with]
      self.no_browser = options[:no_browser]
      self.assets_folder = options[:assets_folder] || self.root
      self.javascripts_path = options[:javascripts_path]
      self.stylesheets_path = options[:stylesheets_path]
      self.for_rails = options[:for_rails]
    end

    def root=(path)
      @root = File.expand_path(path)
    end
  end

  module Config
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.set(options = {})
      configuration.set(options)
    end

    def self.method_missing(method, *args, &block)
      configuration.public_send(method, *args, &block)
    end
  end
end
