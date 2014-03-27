module Rubycritic

  class SourceControlSystem
    @@systems = []

    def self.register_system
      @@systems << self
    end

    def self.create
      supported_system = systems.detect(&:supported?)
      if supported_system
        supported_system.new
      else
        raise "Rubycritic requires a #{system_names} repository."
      end
    end

    def self.systems
      @@systems
    end

    def self.system_names
      systems.join(", ")
    end

    def has_revision?
      raise NotImplementedError.new("You must implement the has_revision? method.")
    end

    def travel_to_head
      raise NotImplementedError.new("You must implement the travel_to_head method.")
    end

    def head_reference
      raise NotImplementedError.new("You must implement the head_reference method.")
    end
  end

end

require "rubycritic/source_control_systems/git"
