require "json"
require "rubycritic/generators/base"

module Rubycritic
  module Generator
    module Json

      class Simple < Base
        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
        end

        def file_name
          "rubycritic.json"
        end

        def render
          JSON.dump(data)
        end

        def data
          {
            :rubycritic => {
              :version => Rubycritic::VERSION
            },
            :analysed_modules => @analysed_modules
          }
        end
      end

    end
  end
end
