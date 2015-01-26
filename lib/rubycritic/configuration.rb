module Rubycritic
  class Configuration
    attr_reader :root
    attr_accessor :source_control_system, :mode, :ignore_symlinks

    def set(options)
      self.mode = options[:mode] || :default
      self.root = options[:root] || "tmp/rubycritic"
      self.ignore_symlinks = options[:ignore_symlinks] || false
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
