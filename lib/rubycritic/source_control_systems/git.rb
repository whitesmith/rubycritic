module Rubycritic

  class Git < SourceControlSystem
    register_system

    def self.supported?
      `git branch 2>&1` && $?.success?
    end

    def self.to_s
      "Git"
    end
  end

end
