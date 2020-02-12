# frozen_string_literal: true

require 'flay'

module RubyCritic
  class Flay < ::Flay
    def initialize(paths)
      super()
      paths = PathExpander.new([], '').filter_files(paths, DEFAULT_IGNORE)
      process(*paths)
      analyze
    end
  end
end
