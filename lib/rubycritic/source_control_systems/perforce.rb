# frozen_string_literal: true

require 'date'

module RubyCritic
  module SourceControlSystem
    PERFORCE_FSTAT_OPTS = '-F "clientFile=*.rb" -T clientFile,headRev,headTime,headChange,action'.freeze
    PerforceStats = Struct.new(:filename, :revision, :last_commit, :opened?, :head)

    class Perforce < Base
      register_system

      def self.supported?
        p4_client = ENV['P4CLIENT'] || ''
        p4_installed? && !p4_client.empty? && in_client_directory?
      end

      def self.p4_installed?
        p4_exe = Gem.win_platform? ? 'p4.exe' : 'p4'
        ENV['PATH'].split(File::PATH_SEPARATOR).any? do |directory|
          File.executable?(File.join(directory, p4_exe))
        end
      end

      def self.in_client_directory?
        p4_info = `p4 info`.each_line.select do |line|
          line.start_with?('Client root', 'Current directory')
        end

        client_directory, current_directory = p4_info.map! { |info| info.split(': ').last.chomp }
        child?(client_directory, current_directory)
      end

      def self.child?(root, target)
        root_size = root.size
        target_size = target.size
        return false if target_size < root_size

        target[0...root_size] == root &&
          (target_size == root_size || [File::ALT_SEPARATOR, File::SEPARATOR].include?(target[root_size]))
      end

      def self.to_s
        'Perforce'
      end

      def revisions_count(path)
        perforce_files[Perforce.key_file(path)].revision.to_i
      end

      def date_of_last_commit(path)
        Time.strptime(perforce_files[Perforce.key_file(path)].last_commit, '%s').strftime('%Y-%m-%d %H:%M:%S %z')
      end

      def revision?
        !perforce_files.values.count(&:opened?).zero?
      end

      def head_reference
        perforce_files.values.map(&:head).max_by(&:to_i)
      end

      def self.build_file_cache
        # Chun is very slow if files stats are requested one by one
        # this fill a hash with the result of all ruby file in the current directory (and sub-directories)
        {}.tap do |file_cache|
          line_aggregator = []
          `p4 fstat #{PERFORCE_FSTAT_OPTS} #{Dir.getwd}...`.each_line do |line|
            Perforce.compute_line(file_cache, line_aggregator, line)
          end
          # handle remaining lines
          Perforce.insert_file_cache(file_cache, line_aggregator) if line_aggregator.any?
        end
      end

      def self.compute_line(file_cache, line_aggregator, line)
        if line.chomp.empty?
          Perforce.insert_file_cache(file_cache, line_aggregator)
        else
          line_aggregator << line
        end
      end

      def self.insert_file_cache(file_cache, lines)
        perforce_stat = Perforce.compute_cache_lines(lines)
        file_cache[perforce_stat.filename] = perforce_stat
        lines.clear
      end

      def self.compute_cache_lines(lines)
        perforce_lines = Hash[*lines.map { |line| line.split[1..-1] }.flatten]
        PerforceStats.new(
          Perforce.normalized_file_path(perforce_lines['clientFile']),
          perforce_lines['headRev'],
          perforce_lines['headTime'],
          perforce_lines.key?('action'),
          perforce_lines['headChange']
        )
      end

      def self.key_file(source_file_path)
        Perforce.normalized_file_path(File.join(Dir.getwd, source_file_path))
      end

      def self.normalized_file_path(file_path)
        file_path.downcase.tr('\\', '/')
      end

      private

      def perforce_files
        @perforce_files ||= Perforce.build_file_cache
      end
    end
  end
end
