# frozen_string_literal: true

require 'flay'

module RubyCritic
  class Flay < ::Flay
    def initialize(paths)
      super()
      process(*paths)
      analyze
    end
  end
end
