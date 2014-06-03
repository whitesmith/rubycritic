require "rubycritic/active_support/methods"
require "rubycritic/adapters/smell/flay"
require "rubycritic/adapters/smell/flog"
require "rubycritic/adapters/smell/reek"

module Rubycritic

  class AnalysersRunner
    include ActiveSupport

    ANALYSERS = ["Flay", "Flog", "Reek"]

    def initialize(analysed_files)
      @analysed_files = analysed_files
    end

    def run
      ANALYSERS.map do |analyser_name|
        constantize("Rubycritic::SmellAdapter::#{analyser_name}").new(@analysed_files).smells
      end
    end
  end

end
