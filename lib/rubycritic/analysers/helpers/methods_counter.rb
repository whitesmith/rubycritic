# frozen_string_literal: true

require 'rubycritic/analysers/helpers/parser'

module RubyCritic
  class MethodsCounter
    def initialize(analysed_module)
      @analysed_module = analysed_module
    end

    def count
      node.count_nodes_of_type(:def, :defs)
    end

    private

    def node
      Parser.parse(content)
    end

    def content
      File.read(@analysed_module.path)
    end
  end
end
