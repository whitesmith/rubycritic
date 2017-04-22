# frozen_string_literal: true

require 'test_helper'

class AnalysedModuleDouble < OpenStruct; end

require_relative '../lib/rubycritic/core/analysed_modules_collection'
class AnalysedModulesCollectionDouble < RubyCritic::AnalysedModulesCollection
  def initialize(module_doubles)
    @modules = module_doubles
  end
end
