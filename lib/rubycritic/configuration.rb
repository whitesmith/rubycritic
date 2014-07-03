require "pathname"

module Rubycritic
  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_reader :root

    def initialize
      self.root = "tmp/rubycritic"
    end

    def root=(path)
      @root =
        if Pathname(path).relative?
          File.expand_path(path)
        else
          path
        end
    end
  end
end
