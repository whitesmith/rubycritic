# frozen_string_literal: true

require 'tty/which'

module RubyCritic
  module SourceControlSystem
    class Git < Base
      register_system
      GIT_EXECUTABLE = TTY::Which.which('git')

      def self.git(arg)
        if Gem.win_platform?
          `\"#{GIT_EXECUTABLE}\" #{arg}`
        else
          `#{GIT_EXECUTABLE} #{arg}`
        end
      end

      def git(arg)
        self.class.git(arg)
      end

      def self.supported?
        git('branch 2>&1') && $CHILD_STATUS.success?
      end

      def self.to_s
        'Git'
      end

      def revisions_count(path)
        git("log --follow --format=%h #{path.shellescape}").count("\n")
      end

      def date_of_last_commit(path)
        git("log -1 --date=iso --format=%ad #{path.shellescape}").chomp!
      end

      def revision?
        head_reference && $CHILD_STATUS.success?
      end

      def head_reference
        git('rev-parse --verify HEAD').chomp!
      end

      def travel_to_head
        stash_successful = stash_changes
        yield
      ensure
        travel_to_original_state if stash_successful
      end

      def self.switch_branch(branch)
        uncommitted_changes? ? abort('Uncommitted changes are present.') : `git checkout #{branch}`
      end

      def self.uncommitted_changes?
        !`git diff-index HEAD --`.empty?
      end

      def self.modified_files
        modified_files = `git diff --name-status #{Config.base_branch} #{Config.feature_branch}`
        modified_files.split("\n").map do |line|
          next if line.start_with?('D')

          file_name = line.split("\t")[1]
          file_name
        end.compact
      end

      def self.current_branch
        branch_list = `git branch`
        branch_list.match(/\*.*$/)[0].gsub('* ', '')
      end

      private

      def stash_changes
        stashes_count_before = stashes_count
        git('stash')
        stashes_count_after = stashes_count
        stashes_count_after > stashes_count_before
      end

      def stashes_count
        git('stash list --format=%h').count("\n")
      end

      def travel_to_original_state
        git('stash pop')
      end
    end
  end
end
