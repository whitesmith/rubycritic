require "virtus"

module Rubycritic

  class AnalysedFile
    include Virtus.model

    attribute :pathname
    attribute :smells
    attribute :churn
    attribute :complexity

    def has_smells?
      !smells.empty?
    end
  end

end
