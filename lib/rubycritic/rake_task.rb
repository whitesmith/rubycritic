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

    def initialize(name = :rubycritic)
      @name    = name
      @paths   = FileList['.']
      @options = ''
      @verbose = false

      yield self if block_given?
      define_task
    end

    private

    attr_reader :name, :paths, :verbose, :options

    def define_task
      desc 'Run RubyCritic'
      task(name) { run_task }
    end

    def run_task
      if verbose
        puts "\n\n!!! Running `#{name}` rake command\n"
        puts "!!! Inspecting #{paths} #{options.empty? ? '' : "with options #{options}"}\n\n"
      end
      application = RubyCritic::Cli::Application.new(options_as_arguments + paths)
      application.execute
    end

    def options_as_arguments
      options.split(/\s+/)
    end
  end
end
