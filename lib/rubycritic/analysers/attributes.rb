require "rubycritic/analysers/adapters/methods_counter"

module Rubycritic
  module Analyser

    class Attributes
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.methods_count = MethodsCounter.count(analysed_module.path)
        end
      end
    end

  end
end
