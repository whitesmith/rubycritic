require "parser/current"
require "rubycritic/analysers/helpers/ast_node"

module Rubycritic

  class ModulesLocator
    def initialize(analysed_module)
      @analysed_module = analysed_module
    end

    def first_name
      names.first
    end

    def names
      return name_from_path if @analysed_module.methods_count == 0

      content = File.read(@analysed_module.path)
      node = Parser::CurrentRuby.parse(content)
      return name_from_path unless node

      names = node.get_module_names
      if names.empty?
        name_from_path
      else
        names
      end
    rescue Parser::SyntaxError => error
      name_from_path
    end

    private

    def name_from_path
      [@analysed_module.pathname.basename.sub_ext("").to_s.split("_").map(&:capitalize).join]
    end
  end

end
