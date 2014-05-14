require "pathname"

module Rubycritic

  class SourceLocator
    RUBY_EXTENSION = ".rb"
    RUBY_FILES = File.join("**", "*#{RUBY_EXTENSION}")

    def initialize(paths)
      @initial_paths = paths
    end

    def paths
      @paths ||= pathnames.map(&:to_s)
    end

    def pathnames
      @pathnames ||= expand_paths
    end

    private

    def expand_paths
      @initial_paths.map do |path|
        if File.directory?(path)
          Pathname.glob(File.join(path, RUBY_FILES))
        elsif File.exists?(path) && File.extname(path) == RUBY_EXTENSION
          Pathname.new(path)
        end
      end.flatten.compact.map(&:cleanpath).sort
    end
  end

end
