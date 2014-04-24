require "pathname"

module Rubycritic

  class SourceLocator
    RUBY_EXTENSION = ".rb"
    RUBY_FILES = File.join("**", "*#{RUBY_EXTENSION}")

    def initialize(paths)
      @user_paths = paths
    end

    def pathnames
      @pathnames ||= expand_paths
    end

    def paths
      @paths ||= pathnames.map(&:to_s)
    end

    private

    def expand_paths
      @user_paths.map do |path|
        if File.directory?(path)
          Pathname.glob(File.join(path, RUBY_FILES))
        elsif File.exists?(path) && File.extname(path) == RUBY_EXTENSION
          Pathname.new(path)
        end
      end.flatten.compact.map(&:cleanpath).sort
    end
  end

end
