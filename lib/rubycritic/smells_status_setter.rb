module Rubycritic

  class SmellsStatusSetter
    def initialize(smelly_pathnames_before, smelly_pathnames_now)
      @smelly_pathnames_before = smelly_pathnames_before
      @smelly_pathnames_now = smelly_pathnames_now
    end

    def smelly_pathnames
      @smelly_pathnames_now.each do |pathname, smells_now|
        smells_before = @smelly_pathnames_before[pathname] || []
        old_smells = smells_now & smells_before
        set_status(old_smells, :old)
        new_smells = smells_now - smells_before
        set_status(new_smells, :new)
      end
      @smelly_pathnames_now
    end

    private

    def set_status(smells, status)
      smells.each { |smell| smell.status = status }
    end
  end

end
