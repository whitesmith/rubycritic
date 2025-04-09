# frozen_string_literal: true

if Gem.loaded_specs['cucumber-core'].version.to_s.start_with?('13.0') &&
   RUBY_VERSION == '3.5.0' && RUBY_PATCHLEVEL == -1
  module Cucumber
    module Core
      module Test
        module Location
          singleton_class.send(:alias_method, :original_from_source_location, :from_source_location)
          def self.from_source_location(file, start_line, _start_column = nil, _end_line = nil, _end_column = nil)
            original_from_source_location(file, start_line)
          end
        end
      end
    end
  end
end

require_relative '../../lib/rubycritic'
require_relative '../../lib/rubycritic/cli/application'
require_relative '../../lib/rubycritic/commands/status_reporter'
require 'aruba/cucumber'
require 'minitest/spec'

#
# Provides runner methods used in the cucumber steps.
#
class RubyCriticWorld
  extend Minitest::Assertions
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end

  def rubycritic(args)
    run_command_and_stop(
      "rubycritic #{args}  --no-browser",
      fail_on_error: false
    )
  end

  def rake(name, task_def)
    header = <<~RUBY
      require 'rubycritic'
      require 'rubycritic/rake_task'

    RUBY
    write_file 'Rakefile', header + task_def
    run_command_and_stop(
      "rake #{name}",
      fail_on_error: false
    )
  end
end

World do
  RubyCriticWorld.new
end

Before do
  Aruba.configure do |config|
    config.exit_timeout = 30
  end
end
