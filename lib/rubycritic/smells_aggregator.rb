module Rubycritic

  class SmellsAggregator
    def initialize(smell_adapters)
      @smell_adapters = smell_adapters
    end

    def smells
      @smells ||= @smell_adapters.map(&:smells).flatten.sort
    end
  end

end
