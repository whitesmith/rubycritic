module Rubycritic
  module Config
    def self.configuration
      @configuration ||= config_class.new
    end

    def self.config_class
      case @mode
      when :rails
        require 'rubycritic/config/rails'
        Config::Rails
      else
        require 'rubycritic/config/default'
        Config::Default
      end
    end

    def self.set(options = {})
      @mode = options[:mode]
      configuration.set(options)
    end

    def self.method_missing(method, *args, &block)
      configuration.public_send(method, *args, &block)
    end
  end
end
