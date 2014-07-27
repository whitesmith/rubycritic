require "parser/current"
require "rubycritic/analysers/helpers/ast_node"

module Rubycritic

  module ModulesLocator
    def self.names(path)
      content = File.read(path)
      node = Parser::CurrentRuby.parse(content)
      return [] unless node
      node.get_module_names
    rescue Parser::SyntaxError => error
      []
    end
  end

end
