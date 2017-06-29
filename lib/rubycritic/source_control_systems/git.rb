# frozen_string_literal: true

require 'rubycritic/source_control_systems/git/revision'

module RubyCritic
  module SourceControlSystem
    class Git < Base
      register_system

      def self.supported?
        `git branch 2>&1` && $?.success?
      end

      def self.to_s
        'Git'
      end

      def revisions_count(path)
        path_revisions_count.fetch(path.shellescape, 0)
      end

      def date_of_last_commit(path)
        `git log -1 --date=iso --format=%ad #{path.shellescape}`.chomp!
      end

      def revision?
        head_reference && $?.success?
      end

      def head_reference
        `git rev-parse --verify HEAD`.chomp!
      end

      def travel_to_head
        stash_successful = stash_changes
        yield
      ensure
        travel_to_original_state if stash_successful
      end

      private

      def stash_changes
        stashes_count_before = stashes_count
        `git stash`
        stashes_count_after = stashes_count
        stashes_count_after > stashes_count_before
      end

      def stashes_count
        `git stash list --format=%h`.count("\n")
      end

      def travel_to_original_state
        `git stash pop`
      end

      def name_status
        `git log --all --name-status --format='' --reverse`
      end

      def path_revisions_count
        @path_revisions_count ||= path_revisions_cache
      end

      def path_revisions_cache
        revisions = [Add, Copy, Delete, Modify, Rename, Double]

        name_status
          .split("\n")
          .map { |string| Revision.parse(revisions, string) }
          .each_with_object({}) { |revision, hash| revision.evaluate(hash) }
      end
    end
  end
end
