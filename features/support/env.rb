# frozen_string_literal: true

require_relative '../../lib/rubycritic'
require_relative '../../lib/rubycritic/cli/application'
require_relative '../../lib/rubycritic/commands/status_reporter'
require 'aruba/cucumber'
require 'minitest/spec'

#
# Provides runner methods used in the cucumber steps.
#
class RubyCriticWorld
  extend MiniTest::Assertions
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
    header = <<-RUBY.strip_heredoc
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
