# frozen_string_literal: true

require 'rubycritic/configuration'

module RubyCritic
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
      else
        require 'rubycritic/commands/default'
        Command::Default
      end
    end
  end
end
