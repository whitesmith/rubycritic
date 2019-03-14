# frozen_string_literal: true

require 'rubycritic/source_control_systems/base'

module RubyCritic
  class Configuration
    attr_reader :root
    attr_accessor :source_control_system, :mode, :formats, :formatters, :deduplicate_symlinks,
                  :suppress_ratings, :open_with, :no_browser, :base_branch,
                  :feature_branch, :base_branch_score, :feature_branch_score,
                  :base_root_directory, :feature_root_directory,
                  :compare_root_directory, :threshold_score, :base_branch_collection,
                  :feature_branch_collection

    def set(options)
      self.mode = options[:mode] || :default
      self.root = options[:root] || 'tmp/rubycritic'
      self.deduplicate_symlinks = options[:deduplicate_symlinks]
      self.suppress_ratings = options[:suppress_ratings]
      self.open_with = options[:open_with]
      self.no_browser = options[:no_browser]
      self.base_branch = options[:base_branch]
      self.feature_branch = options[:feature_branch]
      self.threshold_score = options[:threshold_score].to_i
      setup_formats(options)
    end

    def setup_formats(options)
      formats = options[:formats].to_a
      self.formats = formats.empty? ? [:html] : formats
      self.formatters = options[:formatters] || []
    end

    def root=(path)
      @root = File.expand_path(path)
    end

    def source_control_present?
      source_control_system &&
        !source_control_system.is_a?(SourceControlSystem::Double)
    end
  end

  module Config
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.set(options = {})
      configuration.set(options)
    end

    def self.compare_branches_mode?
      %i[compare_branches ci].include?(Config.mode)
    end

    def self.build_mode?
      !Config.no_browser && %i[compare_branches ci].include?(Config.mode)
    end

    def self.method_missing(method, *args, &block)
      configuration.public_send(method, *args, &block)
    end

    def self.respond_to_missing?(symbol, include_all = false)
      configuration.respond_to_missing?(symbol) || super
    end
  end
end
