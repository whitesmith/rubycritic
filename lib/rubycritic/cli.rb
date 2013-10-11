require "optparse"
require "rubycritic"

module Rubycritic

  OptionParser.new do |opts|
    opts.banner = "Usage: rubycritic [options] [path]"

    opts.on_tail("-v", "--version", "Show this version") do
      require "rubycritic/version"
      puts VERSION
      exit 0
    end

    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit 0
    end
  end.parse!

  # Do something here!
  exit 0

end
