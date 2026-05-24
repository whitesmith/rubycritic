# frozen_string_literal: true

require_relative '../test_helper'
require 'open3'
require 'timeout'
require 'tmpdir'
require 'fileutils'
require_relative '../../lib/rubycritic'
require_relative '../../lib/rubycritic/cli/application'
require_relative '../../lib/rubycritic/commands/status_reporter'

module IntegrationTestHelper
  GEM_ROOT = File.expand_path('../..', __dir__)
  COMMAND_TIMEOUT = 30

  CommandResult = Struct.new(:stdout, :stderr, :exit_status)

  def before_setup
    super
    @sandbox_dir = Dir.mktmpdir('rubycritic-spec-')
    @original_pwd = Dir.pwd
    Dir.chdir(@sandbox_dir)
  end

  def after_teardown
    Dir.chdir(@original_pwd) if @original_pwd
    FileUtils.remove_entry(@sandbox_dir) if @sandbox_dir && File.directory?(@sandbox_dir)
    @sandbox_dir = nil
    @original_pwd = nil
    super
  end

  def write_file(name, contents)
    File.write(File.join(Dir.pwd, name), contents)
  end

  def rubycritic(args)
    run_command("rubycritic #{args} --no-browser")
  end

  def rake(name, task_def)
    header = <<~RUBY
      require 'rubycritic'
      require 'rubycritic/rake_task'

    RUBY
    write_file 'Rakefile', header + task_def
    run_command("rake #{name}")
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

  private

  # rubocop:disable Metrics/AbcSize
  def run_command(command)
    env = { 'PATH' => "#{File.join(GEM_ROOT, 'bin')}#{File::PATH_SEPARATOR}#{ENV.fetch('PATH', '')}" }
    Open3.popen3(env, command) do |stdin, stdout, stderr, wait_thr|
      stdin.close
      out = err = nil
      begin
        Timeout.timeout(COMMAND_TIMEOUT) do
          out = stdout.read
          err = stderr.read
          wait_thr.join
        end
      rescue Timeout::Error
        Process.kill('KILL', wait_thr.pid)
        wait_thr.join
        raise
      end
      return CommandResult.new(out, err, wait_thr.value.exitstatus)
    end
  end
  # rubocop:enable Metrics/AbcSize
end
