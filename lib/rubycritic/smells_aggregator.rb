module Rubycritic

  class SmellsAggregator
    def initialize(smell_adapters)
      @smell_adapters = smell_adapters
    end

    def smells
      @smells ||= @smell_adapters.map(&:smells).flatten.sort
    end

    def smelly_pathnames
      @smelly_pathnames ||= pathnames_to_files_with_smells
    end

    private

    def pathnames_to_files_with_smells
      pathnames = Hash.new { |hash, key| hash[key] = [] }
      smells.each do |smell|
        smell.pathnames.each do |path|
          pathnames[path] << smell
        end
      end
      pathnames
    end
  end

end
