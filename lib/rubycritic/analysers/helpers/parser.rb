require "parser/current"
require "rubycritic/analysers/helpers/ast_node"

module Rubycritic
  module Parser
    def self.parse(content)
      ::Parser::CurrentRuby.parse(content) || AST::EmptyNode.new
    rescue ::Parser::SyntaxError
      AST::EmptyNode.new
    end
  end
end
