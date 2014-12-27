module Rubycritic
  module SourceControlSystem

    class Mercurial < Base
      register_system

      def self.supported?
        `hg verify 2>&1` && $?.success?
      end

      def self.to_s
        "Mercurial"
      end

      def revisions_count(path)
        `hg log #{path.shellescape} --template '1'`.size
      end

      def date_of_last_commit(path)
        `hg log #{path.shellescape} --template '{date|isodate}' --limit 1`.chomp
      end

      def revision?
        false
      end
    end

  end
end
