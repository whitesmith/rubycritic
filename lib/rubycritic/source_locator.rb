module Rubycritic

  class SourceLocator
    RUBY_FILES = File.join("**", "*.rb")

    def initialize(dirs)
      @dirs = dirs
    end

    def pathnames
      @pathnames ||= expand_paths
    end

    def paths
      @paths ||= pathnames.map(&:to_s)
    end

    private

    def expand_paths
      @dirs.map do |path|
        if File.directory?(path)
          Pathname.glob(RUBY_FILES)
        elsif File.exists?(path)
          Pathname.new(path)
        end
      end.flatten.compact.sort
    end
  end

end
