# frozen_string_literal: true
require 'rubycritic/analysers/helpers/flay'
require 'rubycritic/core/smell'

module RubyCritic
  module Analyser
    class FlaySmells
      def initialize(analysed_modules, logger=nil)
        @analysed_modules = paths_to_analysed_modules(analysed_modules)
        @logger = logger
        @flay = Flay.new(@analysed_modules.keys)
      end

      def run
        hashes = @flay.hashes
        skip_logging = @logger.nil?
        hashes.each do |structural_hash, nodes|
          smell = create_smell(structural_hash, nodes)
          nodes.map(&:file).uniq.each do |file|
            @analysed_modules[file].smells << smell
          end

          nodes.each do |node|
            @analysed_modules[node.file].duplication += node.mass
          end

          @logger.report_completion unless skip_logging
        end

        @logger.report_completion @analysed_modules.size - hashes.size unless skip_logging
      end

      def to_s
        'flay smells'
      end

      private

      def paths_to_analysed_modules(analysed_modules)
        paths = {}
        analysed_modules.each do |analysed_module|
          paths[analysed_module.path] = analysed_module
        end
        paths
      end

      def create_smell(structural_hash, nodes)
        mass = @flay.masses[structural_hash]
        Smell.new(
          locations: smell_locations(nodes),
          context: similarity(structural_hash),
          message: "found in #{nodes.size} nodes",
          score: mass,
          type: 'DuplicateCode',
          analyser: 'flay',
          cost: cost(mass)
        )
      end

      def smell_locations(nodes)
        nodes.map do |node|
          Location.new(node.file, node.line)
        end.sort
      end

      def similarity(structural_hash)
        if @flay.identical[structural_hash]
          'Identical code'
        else
          'Similar code'
        end
      end

      def cost(mass)
        mass / 25
      end
    end
  end
end
