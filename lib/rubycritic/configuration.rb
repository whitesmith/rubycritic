module Rubycritic
  class Configuration
    attr_reader :root
    attr_accessor :source_control_system, :mode, :format, :deduplicate_symlinks,
      :suppress_ratings

    def set(options)
      self.mode = options[:mode] || :default
      self.root = options[:root] || "tmp/rubycritic"
      self.format = options[:format] || :html
      self.deduplicate_symlinks = options[:deduplicate_symlinks] || false
      self.suppress_ratings = options[:suppress_ratings] || false
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
