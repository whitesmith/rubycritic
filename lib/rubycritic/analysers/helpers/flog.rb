# frozen_string_literal: true

require 'flog'

module RubyCritic
  class Flog < ::Flog
    DEFAULT_OPTIONS = {
      all: true,
      continue: true,
      methods: true
    }.freeze

    def initialize
      super(DEFAULT_OPTIONS)
    end
  end
end
