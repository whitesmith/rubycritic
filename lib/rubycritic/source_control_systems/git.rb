# frozen_string_literal: true

require 'tty/which'
require 'rubycritic/source_control_systems/git/churn'

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

      def churn
        @churn ||= Churn.new(churn_after: Config.churn_after, paths: Config.paths)
      end

      def revisions_count(path)
        churn.revisions_count(path)
      end

      def date_of_last_commit(path)
        churn.date_of_last_commit(path)
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
        dirty = !uncommitted_changes.empty?
        abort("Uncommitted changes are present: #{uncommitted_changes}") if dirty

        git("checkout #{branch}")
      end

      def self.uncommitted_changes
        return @uncommitted_changes if defined? @uncommitted_changes

        @uncommitted_changes = git('diff-index HEAD --').chomp! || ''
      end

      def self.modified_files
        modified_files = `git diff --name-status #{Config.base_branch} #{Config.feature_branch}`
        modified_files.split("\n").filter_map do |line|
          next if line.start_with?('D')

          file_name = line.split("\t")[1]
          file_name
        end
      end

      def self.current_branch
        branch_list = `git branch`
        branch = branch_list.match(/\*.*$/)[0].gsub('* ', '')
        branch = branch.gsub(/\(HEAD detached at (.*)\)$/, '\1') if /\(HEAD detached at (.*)\)$/.match?(branch)
        branch
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
