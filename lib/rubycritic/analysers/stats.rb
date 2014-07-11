require "parser/current"
require "rubycritic/analysers/adapters/ast_node"

module Rubycritic
  module Analyser

    class Stats
      def initialize(analysed_files)
        @analysed_files = analysed_files
      end

      def run
        @analysed_files.each do |analysed_file|
          analysed_file.methods_count = methods_count(analysed_file.path)
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
      end
    end

  end
end
