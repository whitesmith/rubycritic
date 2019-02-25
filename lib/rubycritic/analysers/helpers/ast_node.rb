# frozen_string_literal: true

module Parser
  module AST
    class Node
      MODULE_TYPES = %i[module class].freeze

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

      def module_names
        ast_node_children = children.select do |child|
          child.is_a?(Parser::AST::Node)
        end

        children_modules = ast_node_children.flat_map(&:module_names)

        if MODULE_TYPES.include?(type)
          module_names_with_children children_modules
        else
          children_modules
        end
      end

      private

      def module_names_with_children(children_modules)
        if children_modules.empty?
          [module_name]
        else
          children_modules.map do |children_module|
            "#{module_name}::#{children_module}"
          end
        end
      end

      def module_name
        name_segments = []
        current_node = children[0]
        while current_node
          name_segments.unshift(current_node.children[1])
          current_node = current_node.children[0]
        end
        name_segments.join('::')
      end
    end
  end
end

module RubyCritic
  module AST
    class EmptyNode
      def count_nodes_of_type(*)
        0
      end

      def module_names
        []
      end
    end
  end
end
