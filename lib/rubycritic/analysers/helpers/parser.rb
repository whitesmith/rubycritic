# frozen_string_literal: true

require 'parser/current'
require 'rubycritic/analysers/helpers/ast_node'

module RubyCritic
  module Parser
    def self.parse(content)
      ::Parser::CurrentRuby.parse(content) || AST::EmptyNode.new
    rescue ::Parser::SyntaxError
      AST::EmptyNode.new
    end
  end
end
