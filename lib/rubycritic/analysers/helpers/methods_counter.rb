require "parser/current"
require "rubycritic/analysers/helpers/ast_node"

module Rubycritic

  class MethodsCounter
    def initialize(analysed_module)
      @analysed_module = analysed_module
    end

    def count
      node.count_nodes_of_type(:def, :defs)
    end

    private

    def node
      Parser::CurrentRuby.parse(content) || AST::EmptyNode.new
    rescue Parser::SyntaxError => error
      AST::EmptyNode.new
    end

    def content
      File.read(@analysed_module.path)
    end
  end

end
