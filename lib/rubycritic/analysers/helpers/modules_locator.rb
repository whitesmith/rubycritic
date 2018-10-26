# frozen_string_literal: true

require 'rubycritic/analysers/helpers/parser'

module RubyCritic
  class ModulesLocator
    def initialize(analysed_module)
      @analysed_module = analysed_module
    end

    def first_name
      names.first
    end

    def names
      names = node.module_names
      if names.empty?
        name_from_path
      else
        names
      end
    end

    private

    def node
      Parser.parse(content)
    end

    def content
      File.read(@analysed_module.path)
    end

    def name_from_path
      [file_name.split('_').map(&:capitalize).join]
    end

    def file_name
      @analysed_module.pathname.basename.sub_ext('').to_s
    end
  end
end
