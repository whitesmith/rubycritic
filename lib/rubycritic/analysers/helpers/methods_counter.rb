require "parser/current"
require "rubycritic/analysers/helpers/ast_node"

module Rubycritic

  module MethodsCounter
    def self.count(path)
      content = File.read(path)
      node = parse_content(content)
      node.count_nodes_of_type(:def, :defs)
    end

    def self.parse_content(content)
      Parser::CurrentRuby.parse(content) || AST::EmptyNode.new
    rescue Parser::SyntaxError => error
      AST::EmptyNode.new
    end
  end

end
