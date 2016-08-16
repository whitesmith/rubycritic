require 'json'
require 'rubycritic/version'
require 'pathname'

module RubyCritic
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
            metadata: {
              rubycritic: {
                version: RubyCritic::VERSION
              }
            },
            analysed_modules: @analysed_modules,
            score: @analysed_modules.score
          }
        end

        def file_directory
          @file_directory ||= Pathname.new(Config.root)
        end

        def file_name
          'report.json'
        end

        def file_pathname
          File.join(file_directory, file_name)
        end
      end
    end
  end
end
