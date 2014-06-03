module Rubycritic

  class SmellsStatusSetter
    def initialize(smells_before, smells_now)
      @smells_before = smells_before
      @smells_now = smells_now
    end

    def set
      old_smells = @smells_now & @smells_before
      set_status(old_smells, :old)
      new_smells = @smells_now - @smells_before
      set_status(new_smells, :new)
    end

    private

    def set_status(smells, status)
      smells.each { |smell| smell.status = status }
    end
  end

end
