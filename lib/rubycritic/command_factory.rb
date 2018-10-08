# frozen_string_literal: true

require 'rubycritic/configuration'

module RubyCritic
  class CommandFactory
    COMMAND_CLASS_MODES = %i[version help ci compare default].freeze

    def self.create(options = {})
      Config.set(options)
      command_class(Config.mode).new(options)
    end

    def self.command_class(mode)
      mode = mode.to_s.split('_').first.to_sym
      if COMMAND_CLASS_MODES.include? mode
        require "rubycritic/commands/#{mode}"
        Command.const_get(mode.capitalize)
      else
        require 'rubycritic/commands/default'
        Command::Default
      end
    end
  end
end
