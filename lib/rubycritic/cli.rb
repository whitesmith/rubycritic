require "optparse"
require "rubycritic"
require "rubycritic/orchestrator"

module Rubycritic

  OptionParser.new do |opts|
    opts.banner = "Usage: rubycritic [options] [paths]"

    opts.on("-p", "--path [PATH]", "Set path where report will be saved (tmp/rubycritic by default)") do |path|
      configuration.root = path
    end

    opts.on_tail("-v", "--version", "Show gem's version") do
      require "rubycritic/version"
      puts VERSION
      exit 0
    end

    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit 0
    end
  end.parse!

  ARGV << "." if ARGV.empty?
  puts "New critique at #{Orchestrator.new.critique(ARGV)}"
  exit 0

end
