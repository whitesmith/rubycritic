require "virtus"

module Rubycritic

  class AnalysedFile
    include Virtus.model

    attribute :pathname
    attribute :smells
    attribute :churn
    attribute :complexity
  end

end
