# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'
require 'English'
require 'rubycritic/cli/application'

module RubyCritic
  #
  # A rake task that runs RubyCritic on a set of source files.
  #
  # This will create a task that can be run with:
  #
  #   rake rubycritic
  #
  # Example:
  #
  #   require 'rubycritic/rake_task'
  #
  #   RubyCritic::RakeTask.new do |task|
  #     task.paths = FileList['lib/**/*.rb', 'spec/**/*.rb']
  #   end
  #
  class RakeTask < ::Rake::TaskLib
    # Name of RubyCritic task. Defaults to :rubycritic.
    attr_writer :name

    # Glob pattern to match source files. Defaults to FileList['.'].
    attr_writer :paths

    # Use verbose output. If this is set to true, the task will print
    # the rubycritic command to stdout. Defaults to false.
    attr_writer :verbose

    # You can pass all the options here in that are shown by "rubycritic -h" except for
    # "-p / --path" since that is set separately. Defaults to ''.
    attr_writer :options

    # Whether or not to fail Rake task when RubyCritic does not pass.
    # Defaults to true.
    attr_writer :fail_on_error

    def initialize(name = :rubycritic, description = 'Run RubyCritic')
      @name           = name
      @description    = description
      @paths          = FileList['.']
      @options        = ''
      @verbose        = false
      @fail_on_error  = true

      yield self if block_given?
      define_task
    end

    private

    attr_reader :name, :description, :paths, :verbose, :options, :fail_on_error

    def define_task
      desc description
      task(name) { run_task }
    end

    def run_task
      print_starting_up_output if verbose
      application = RubyCritic::Cli::Application.new(options_as_arguments + paths)
      return unless application.execute.nonzero? && fail_on_error

      abort('RubyCritic did not pass - exiting!')
    end

    def print_starting_up_output
      puts "\n\n!!! Running `#{name}` rake command\n"
      puts "!!! Inspecting #{paths} #{options.empty? ? '' : "with options #{options}"}\n\n"
    end

    def options_as_arguments
      options.split(/\s+/)
    end
  end
end
