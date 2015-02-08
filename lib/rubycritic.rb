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
      Command::Help.new(options.help_text)
    when :ci
      require "rubycritic/commands/ci"
      Command::Ci.new(options_hash[:paths])
    else
      require "rubycritic/commands/default"
      Command::Default.new(options_hash[:paths])
    end
  end
end
