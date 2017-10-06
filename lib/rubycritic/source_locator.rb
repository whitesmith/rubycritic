# frozen_string_literal: true

require 'pathname'
require 'rubycritic/configuration'

module RubyCritic
  class SourceLocator
    RUBY_EXTENSION = '.rb'.freeze
    RUBY_FILES = File.join('**', "*#{RUBY_EXTENSION}")

    def initialize(paths)
      @initial_paths = Array(paths)
    end

    def paths
      @paths ||= pathnames.map(&:to_s)
    end

    def pathnames
      @pathnames ||= expand_paths
    end

    private

    def deduplicate_symlinks(path_list)
      # sort the symlinks to the end so files are preferred
      path_list.sort_by! { |path| File.symlink?(path.cleanpath) ? 'z' : 'a' }
      if defined?(JRUBY_VERSION)
        require 'java'
        path_list.uniq! do |path|
          java.io.File.new(path.realpath.to_s).canonical_path
        end
      else
        path_list.uniq!(&:realpath)
      end
    end

    def expand_paths
      path_list = @initial_paths.flat_map do |path|
        if File.directory?(path)
          Pathname.glob(File.join(path, RUBY_FILES))
        elsif File.exist?(path) && File.extname(path) == RUBY_EXTENSION
          Pathname.new(path)
        end
      end.compact

      deduplicate_symlinks(path_list) if Config.deduplicate_symlinks

      path_list.map(&:cleanpath)
    end
  end
end
