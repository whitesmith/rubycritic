require "reek"
require "reek/configuration/app_configuration"
require "ostruct"

module Rubycritic

  class Reek < ::Reek::Examiner
    DEFAULT_CONFIG_FILE = File.expand_path("../config.reek", __FILE__)

    def initialize(paths)
      config = OpenStruct.new(:options => OpenStruct.new(:config_file => DEFAULT_CONFIG_FILE))
      ::Reek::Configuration::AppConfiguration.initialize_with(config)
      super(Array(paths))
    end
  end

end
