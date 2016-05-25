require 'rubycritic/config'
require 'rubycritic/config/base'
require 'rubycritic/config/default'

module Rubycritic
  class CommandFactory
    def self.create(options = {})
      Config.set(options)
      command_class(Config.mode).new(options)
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
      when :rails
        require 'rubycritic/commands/rails'
        require 'rubycritic/config/rails'
        Command::Rails
      else
        require 'rubycritic/commands/default'
        Command::Default
      end
    end
  end
end
