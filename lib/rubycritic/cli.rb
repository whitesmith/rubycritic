require "optparse"
require "rubycritic"
require "rubycritic/reporters/main"

module Rubycritic

  class Cli
    STATUS_SUCCESS = 0

    def initialize(argv)
      @argv = argv
      @argv << "." if @argv.empty?
      @main_command = true
    end

    def execute
      OptionParser.new do |opts|
        opts.banner = "Usage: rubycritic [options] [paths]"

        opts.on("-p", "--path [PATH]", "Set path where report will be saved (tmp/rubycritic by default)") do |path|
          ::Rubycritic.configuration.root = path
        end

        opts.on_tail("-v", "--version", "Show gem's version") do
          require "rubycritic/version"
          puts "RubyCritic #{VERSION}"
          @main_command = false
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          @main_command = false
        end
      end.parse!(@argv)

      if @main_command
        analysed_files = Orchestrator.new.critique(@argv)
        report_location = Reporter::Main.new(analysed_files).generate_report
        puts "New critique at #{report_location}"
      end

      STATUS_SUCCESS
    end
  end

end
