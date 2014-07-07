require "parser/current"

module Rubycritic
  module Analyser

    class Stats
      def initialize(analysed_files)
        @analysed_files = analysed_files
      end

      def stats
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
        Parser::CurrentRuby.parse(content)
      end
    end

  end
end

class Parser::AST::Node
  def count_nodes_of_type(*types)
    count = 0
    recursive_children do |child|
      count += 1 if types.include?(child.type)
    end
    count
  end

  def recursive_children
    children.each do |child|
      next unless child.is_a?(Parser::AST::Node)
      yield child
      child.recursive_children { |grand_child| yield grand_child }
    end
  end
end
