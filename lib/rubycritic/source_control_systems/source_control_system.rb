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

    def self.supported?
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end

    def has_revision?
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end

    def head_reference
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end

    def travel_to_head
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end

    def revisions_count(file)
      raise NotImplementedError.new("The #{self.class} class must implement the #{__method__} method.")
    end
  end

end

require "rubycritic/source_control_systems/git"
