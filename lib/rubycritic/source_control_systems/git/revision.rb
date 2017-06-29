# frozen_string_literal: true

module RubyCritic
  module SourceControlSystem
    class Git < Base
      class Revision
        def initialize(path, new_path)
          @path = path
          @new_path = new_path
        end

        def self.matches?(status)
          match =~ status
        end

        def self.parse(revisions, string)
          status, path, new_path = string.split("\t").map(&:shellescape)
          revisions
            .find { |revision| revision.matches?(status) }
            .new(path, new_path)
        end

        private

        attr_reader :path, :new_path
      end

      class Double < Revision
        def evaluate(_) end

        def self.match
          //
        end
      end

      class Add < Revision
        def evaluate(hash)
          hash[path] = 1
        end

        def self.match
          /A/
        end
      end

      class Copy < Revision
        def evaluate(hash)
          hash[new_path] = 1
        end

        def self.match
          /C/
        end
      end

      class Delete < Revision
        def evaluate(hash)
          hash.delete(path)
        end

        def self.match
          /D/
        end
      end

      class Modify < Revision
        def evaluate(hash)
          hash[path] = hash.fetch(path, 0) + 1
        end

        def self.match
          /M|T/
        end
      end

      class Rename < Revision
        def evaluate(hash)
          value = hash.delete(path) || 0
          hash[new_path] = value + 1
        end

        def self.match
          /R/
        end
      end
    end
  end
end
