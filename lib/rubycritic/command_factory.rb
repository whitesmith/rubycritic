# frozen_string_literal: true

require 'rubycritic/configuration'

module RubyCritic
  class CommandFactory
    def self.create(options = {})
      Config.set(options)
      command_class(Config.command).new(options)
    end

    def self.command_class(command)
      require "rubycritic/commands/#{command}"
      Command.const_get(command.capitalize)
    end
  end
end
