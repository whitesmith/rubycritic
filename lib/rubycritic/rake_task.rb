require "rake"
require "rake/tasklib"

module Rubycritic
  class RakeTask < ::Rake::TaskLib
    attr_accessor :name
    attr_accessor :report
    attr_accessor :format
    attr_accessor :paths
    attr_accessor :options

    def initialize(*args, &task_block)
      @name = args.shift || :rubycritic
      @fail_on_error = true
      @options = []
      @format = "html"
      @report = nil
      @paths = []

      desc "Run RubyCritic" unless ::Rake.application.last_comment

      task(name, *args) do |_, task_args|
        task_block.call(*[self, task_args].slice(0, task_block.arity)) if task_block
        run
      end
    end

    def run
      # Lazy-load RubyCritic so that the task doesn't dramatically impact the
      # load time of your Rakefile.
      require "rubycritic"
      require "rubycritic/cli/options"

      options = Rubycritic::Cli::Options.new(full_options).parse
      Rubycritic.create(options).execute
    end

    private

    def full_options
      [].tap do |result|
        result.concat(options)
        result.concat(["--path", report]) if report
        result.concat(["--format", format])
        result.concat(Array(paths))
      end
    end
  end
end

