require "rubycritic/source_locator"
require "rubycritic/core/analysed_module"

module Rubycritic

  module ModulesInitializer
    def self.init(paths)
      SourceLocator.new(paths).pathnames.map do |pathname|
        AnalysedModule.new(:pathname => pathname)
      end
    end
  end

end
