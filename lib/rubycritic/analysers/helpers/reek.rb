require "reek"

module Rubycritic

  class Reek < ::Reek::Examiner
    DEFAULT_CONFIG_FILES = [File.expand_path("../config.reek", __FILE__)]

    def initialize(paths)
      super(Array(paths), DEFAULT_CONFIG_FILES)
    end
  end

end
