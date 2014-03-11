module Rubycritic

  class SourceLocator
    RUBY_FILES = File.join("**", "*.rb")

    def initialize(paths)
      @paths = paths
    end

    def source_files
      @source_files ||= expand_paths
    end

    private

    def expand_paths
      @paths.map do |path|
        if File.directory?(path)
          Dir.glob(RUBY_FILES)
        elsif File.exists?(path)
          path
        else
          next
        end
      end.flatten.compact.sort
    end
  end

end
