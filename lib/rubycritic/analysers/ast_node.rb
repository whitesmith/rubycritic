module Parser
  module AST

    class Node
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

  end
end

module Rubycritic
  module AST

    class EmptyNode
      def count_nodes_of_type(*types)
        0
      end
    end

  end
end
