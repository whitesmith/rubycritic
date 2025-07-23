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

      # :reek:TooManyInstanceVariables
      class Churn
        # :reek:TooManyStatements
        def initialize(churn_after: nil, paths: ['.'])
          @churn_after = churn_after
          @paths = Array(paths)
          @date = nil
          @stats = {}
          @git_root = find_git_root

          call
        end

        def revisions_count(path)
          stats(path).count
        end

        def date_of_last_commit(path)
          stats(path).date
        end

        private

        # :reek:DuplicateMethodCall
        def find_git_root
          @paths.each do |path|
            current_path = File.expand_path(path)
            while current_path != File.dirname(current_path)
              if Dir.exist?(File.join(current_path, '.git'))
                return current_path
              end
              current_path = File.dirname(current_path)
            end
          end
          Dir.pwd
        end

        def call
          git_log_commands.each { |log_command| exec_git_command(log_command) }
        end

        def exec_git_command(command)
          # Run git command from the git repository root
          Dir.chdir(@git_root) do
            Git
              .git(command)
              .split("\n")
              .reject(&:empty?)
              .each { |line| process_line(line) }
          end
        end

        def git_log_commands
          @paths.map { |path| git_log_command(path) }
        end

        def git_log_command(path)
          # Convert absolute paths to relative paths from git root
          relative_path = make_relative_to_git_root(path)
          "log --all --date=iso --follow --format='format:date:%x09%ad' --name-status #{after_clause}#{relative_path}"
        end

        def make_relative_to_git_root(path)
          absolute_path = File.expand_path(path)
          if absolute_path.start_with?(@git_root)
            # Convert to relative path from git root
            absolute_path[@git_root.length + 1..-1] || '.'
          else
            # If path is not within git root, use as is
            path
          end
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

        # :reek:DuplicateMethodCall
        def filename_for_subdirectory(filename)
          if @git_root != Dir.pwd
            filename
          else
            git_path = Git.git('rev-parse --show-toplevel')
            cd_path = Dir.pwd
            if cd_path.length > git_path.length
              filename = filename.sub(/^#{Regexp.escape("#{File.basename(cd_path)}/")}/, '')
            end
            [filename]
          end
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

        # :reek:TooManyStatements
        def stats(path)
          # Try the path as-is first
          result = @stats.fetch(path, nil)
          return result if result

          # If not found, try converting absolute path to relative path from git root
          absolute_path = File.expand_path(path)
          if absolute_path.start_with?(@git_root)
            relative_path = absolute_path[@git_root.length + 1..-1]
            return @stats.fetch(relative_path, Stats.new(0))
          end

          # If still not found, try converting relative path to absolute path
          if !path.start_with?('/')
            absolute_path = File.expand_path(path, @git_root)
            return @stats.fetch(absolute_path, Stats.new(0))
          end

          # Default fallback
          @stats.fetch(path, Stats.new(0))
        end
      end
    end
  end
end
