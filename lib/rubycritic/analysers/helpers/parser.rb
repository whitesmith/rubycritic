# frozen_string_literal: true

module RubyCritic
  module Parser
    def self.parse(content)
      parser = parser_class
      require 'rubycritic/analysers/helpers/ast_node'
      parser.parse(content) || AST::EmptyNode.new
    rescue ::Parser::SyntaxError
      AST::EmptyNode.new
    end

    def self.parser_class
      return @parser_class if defined?(@parser_class) && @parser_class

      @parser_class =
        if Gem::Version.new(RUBY_VERSION) <= '3.3'
          require 'parser/current'
          ::Parser::CurrentRuby
        else
          require 'prism'
          ::Prism::Translation::ParserCurrent
        end
    end
    private_class_method :parser_class
  end
end
