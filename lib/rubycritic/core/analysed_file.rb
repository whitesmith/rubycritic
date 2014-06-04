require "virtus"

module Rubycritic

  class AnalysedFile
    include Virtus.model

    attribute :pathname
    attribute :smells
    attribute :churn
    attribute :complexity

    def name
      @name ||= pathname.basename.sub_ext("").to_s
    end

    def path
      @path ||= pathname.to_s
    end

    def has_smells?
      !smells.empty?
    end
  end

end
