require "json"

module Rubycritic
  module Generator
    module Json

      class Simple
        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
        end

        def render
          JSON.dump(data)
        end

        def data
          {
            :metadata => {
              :rubycritic => {
                :version => Rubycritic::VERSION
              }
            },
            :analysed_modules => @analysed_modules
          }
        end
      end

    end
  end
end
