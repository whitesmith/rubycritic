require "rake"
require "rake/tasklib"

module Rubycritic
  class RakeTask < Rake::TaskLib
    attr_accessor :name
    attr_accessor :report
    attr_accessor :format
    attr_accessor :paths
    attr_accessor :options

    def initialize(*args, &task_block)
      setup_ivars(args)

      desc "Run rubycritic" unless ::Rake.application.last_comment

      task(name, *args) do |_, task_args|
        RakeFileUtils.send(:verbose, verbose) do
          if task_block
            task_block.call(*[self, task_args].slice(0, task_block.arity))
          end
          rubycritic
        end
      end
    end

    def rubycritic
      # We lazy-load rubycritic so that the task doesn't dramatically impact the
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

    def setup_ivars(args)
      @name = args.shift || :rubycritic
      @fail_on_error = true
      @options = []
      @format = "html"
      @report = nil
      @paths = []
    end
  end
end
