require "parser/current"
require "rubycritic/analysers/adapters/ast_node"

module Rubycritic
  module Analyser

    class Attributes
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.methods_count = methods_count(analysed_module.path)
        end
      end

      private

      def methods_count(path)
        content = File.read(path)
        node = parse_content(content)
        node.count_nodes_of_type(:def, :defs)
      end

      def parse_content(content)
        Parser::CurrentRuby.parse(content) || AST::EmptyNode.new
      rescue Parser::SyntaxError => error
        AST::EmptyNode.new
      end
    end

  end
end
