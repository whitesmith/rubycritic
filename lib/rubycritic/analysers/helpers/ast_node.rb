module Parser
  module AST

    class Node
      MODULE_TYPES = [:module, :class]

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

      def get_module_names
        children_modules = children
          .select { |child| child.is_a?(Parser::AST::Node) }
          .flat_map { |child| child.get_module_names }

        if MODULE_TYPES.include?(self.type)
          if children_modules.empty?
            [module_name]
          else
            children_modules.map do |children_module|
              "#{module_name}::#{children_module}"
            end
          end
        elsif children_modules.empty?
          []
        else
          children_modules
        end
      end

      private

      def module_name
        name_segments = []
        current_node = children[0]
        while(current_node) do
          name_segments.unshift(current_node.children[1])
          current_node = current_node.children[0]
        end
        name_segments.join("::")
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
