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
        def initialize(churn_after: nil, paths: ['.'])
          @churn_after = churn_after
          @paths = Array(paths)
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
          git_log_commands.each { |log_command| exec_git_command(log_command) }
        end

        def exec_git_command(command)
          Git
            .git(command)
            .split("\n")
            .reject(&:empty?)
            .each { |line| process_line(line) }
        end

        def git_log_commands
          @paths.map { |path| git_log_command(path) }
        end

        def git_log_command(path)
          "log --all --date=iso --follow --format='format:date:%x09%ad' --name-status #{after_clause}#{path}"
        end

        def after_clause
          @churn_after ? "--after='#{@churn_after}' " : ''
        end

        def process_line(line)
          operation, *rest = line.split("\t")

          case operation
          when /^date:/
            process_date(*rest)
          when /^[RC]/
            process_rename(*rest)
          else
            rest = filename_for_subdirectory(rest[0])
            process_file(*rest)
          end
        end

        def process_date(date)
          @date = date
        end

        def process_rename(from, to)
          renames.renamed(from, to)
          process_file(to)
        end

        def filename_for_subdirectory(filename)
          git_path = Git.git('rev-parse --show-toplevel')
          cd_path = Dir.pwd
          if cd_path.length > git_path.length
            filename = filename.sub(/^#{Regexp.escape("#{File.basename(cd_path)}/")}/, '')
          end
          [filename]
        end

        def process_file(filename)
          record_commit(renames.current(filename), @date)
        end

        def record_commit(filename, date)
          stats = @stats[filename] ||= Stats.new(0, date)
          stats.count += 1
        end

        def renames
          @renames ||= Renames.new
        end

        def stats(path)
          @stats.fetch(path, Stats.new(0))
        end
      end
    end
  end
end
