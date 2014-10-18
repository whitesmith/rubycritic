require "rubycritic/configuration"

module Rubycritic
  def self.create(options = {})
    options_hash = options.to_h
    Config.set(options_hash)
    case Config.mode
    when :version
      require "rubycritic/commands/version"
      Command::Version.new
    when :help
      require "rubycritic/commands/help"
      Command::Help.new(options)
    else
      require "rubycritic/commands/default"
      Command::Default.new(options_hash)
    end
  end
end
