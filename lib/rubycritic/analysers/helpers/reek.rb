require "reek"
require "reek/configuration/app_configuration"
require "ostruct"

module Rubycritic

  class Reek < ::Reek::Examiner
    DEFAULT_CONFIG_FILE = File.expand_path("../config.reek", __FILE__)

    def initialize(pathname)
      config = ::Reek::Configuration::AppConfiguration.from_path(DEFAULT_CONFIG_FILE)
      super(pathname, [], :configuration => config)
    end
  end
end
