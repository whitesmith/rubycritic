module Rubycritic
  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_reader :root

    def initialize
      @root = File.expand_path("tmp/rubycritic")
    end
  end
end
