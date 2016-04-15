require 'rubycritic/configuration'

module Rubycritic
  class CommandFactory
    def self.create(options = {})
      Config.set(options)
      validate_rails_directory if Config.for_rails
      command_class(Config.mode).new(options)
    end

    def self.validate_rails_directory
      raise ArgumentError, 'The option -r should be executed inside a rails app root folder' unless is_a_rails_app?
    end

    def self.is_a_rails_app?
      File.exists?('Gemfile')
    end

    def self.command_class(mode)
      case mode
      when :version
        require 'rubycritic/commands/version'
        Command::Version
      when :help
        require 'rubycritic/commands/help'
        Command::Help
      when :ci
        require 'rubycritic/commands/ci'
        Command::Ci
      else
        require 'rubycritic/commands/default'
        Command::Default
      end
    end
  end
end
