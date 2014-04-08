module Rubycritic

  class Git < SourceControlSystem
    register_system

    def self.supported?
      `git branch 2>&1` && $?.success?
    end

    def self.to_s
      "Git"
    end

    def has_revision?
      head_reference && $?.success?
    end

    def head_reference
      `git rev-parse --verify HEAD`.chomp
    end

    def travel_to_head
      if uncommited_changes?
        stash_successful = stash_changes
      end
      yield
    ensure
      `git stash pop` if stash_successful
    end

    private

    def uncommited_changes?
      !`git status --porcelain`.empty?
    end

    def stash_changes
      stashes_count_before = stashes_count
      `git stash`
      stashes_count_after = stashes_count
      stashes_count_after > stashes_count_before
    end

    def stashes_count
      `git stash list`.split("\n").length
    end
  end

end
