# frozen_string_literal: true

require_relative '../test_helper'
require 'aruba/api'
require_relative '../../lib/rubycritic'
require_relative '../../lib/rubycritic/cli/application'
require_relative '../../lib/rubycritic/commands/status_reporter'

Aruba.configure { |config| config.exit_timeout = 30 }

module IntegrationTestHelper
  include Aruba::Api

  def rubycritic(args)
    run_command_and_stop(
      "rubycritic #{args} --no-browser",
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

  def create_smelly_file
    contents = <<~RUBY
      class AllTheMethods
        def method_missing(method, *args, &block)
          message = "I"
          eval "message = ' did not'"
          eval "message << ' exist,'"
          eval "message << ' but now'"
          eval "message << ' I do.'"
          self.class.send(:define_method, method) { "I did not exist, but now I do." }
          self.send(method)
        end
      end
    RUBY
    write_file('smelly.rb', contents)
  end

  def create_clean_file
    contents = <<~RUBY
      # Explanatory comment
      class Clean
        def foo; end
      end
    RUBY
    write_file('clean.rb', contents)
  end

  def create_empty_file
    write_file('empty.rb', '')
  end
end
