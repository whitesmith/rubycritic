# frozen_string_literal: true

module RubyCritic
  module SourceControlSystem
    class Git < Base
      Stats = Struct.new(:count, :date)

      class Renames
        def initialize
          @data = {}
        end

        def renamed(from, to)
          current = current(to)
          @data[from] = current
        end

        def current(name)
          @data.fetch(name, name)
        end
      end

      class Churn
        def initialize
          @renames = Renames.new
          @date = nil
          @stats = {}

          call
        end

        def revisions_count(path)
          stats(path).count
        end

        def date_of_last_commit(path)
          stats(path).date
        end

        private

        def call
          Git
            .git("log --all --date=iso --follow --format='format:date:%x09%ad' --name-status .")
            .split("\n")
            .reject(&:empty?)
            .each { |line| process_line(line) }
        end

        def process_line(line)
          operation, *rest = line.split("\t")

          case operation
          when /^date:/
            process_date(*rest)
          when /^R/
            process_rename(*rest)
          else
            process_file(*rest)
          end
        end

        def process_date(date)
          @date = date
        end

        def process_rename(from, to)
          @renames.renamed(from, to)
          process_file(to)
        end

        def process_file(filename)
          record_commit(@renames.current(filename), @date)
        end

        def record_commit(filename, date)
          stats = @stats[filename] ||= Stats.new(0, date)
          stats.count += 1
        end

        def stats(path)
          @stats.fetch(path, Stats.new(0))
        end
      end
    end
  end
end
