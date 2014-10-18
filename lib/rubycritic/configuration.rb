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
      @root = File.expand_path(path)
    end
  end
end
