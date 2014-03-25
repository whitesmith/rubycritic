module Rubycritic

  class Git < SourceControlSystem
    register_system

    def self.supported?
      `git branch 2>&1` && $?.success?
    end

    def self.to_s
      "Git"
    end

    def travel_to_head
      if uncommited_changes?
        stashed_changes = `git stash` && $?.success?
      end
      yield
    ensure
      `git stash pop` if stashed_changes
    end

    private

    def uncommited_changes?
      !`git status --porcelain`.empty?
    end
  end

end
