require "rubycritic/source_locator"
require "rubycritic/core/analysed_file"

module Rubycritic

  module FilesInitializer
    def self.init(paths)
      source = SourceLocator.new(paths)
      source.pathnames.map do |pathname|
        AnalysedFile.new(:pathname => pathname, :smells => [])
      end
    end
  end

end
