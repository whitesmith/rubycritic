require "rubycritic/command_factory"

module Rubycritic
  def self.create(options = {})
    CommandFactory.create(options)
  end
end
