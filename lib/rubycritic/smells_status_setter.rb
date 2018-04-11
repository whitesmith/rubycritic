# frozen_string_literal: true

module RubyCritic
  module SmellsStatusSetter
    def self.set(smells_before, smells_now)
      old_smells = smells_now & smells_before
      set_status(old_smells, :old)
      new_smells = smells_now - smells_before
      set_status(new_smells, :new)
    end

    def self.set_status(smells, status)
      smells.each { |smell| smell.status = status }
    end

    private_class_method :set_status
  end
end
