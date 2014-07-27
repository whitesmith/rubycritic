require "rubycritic/analysers/helpers/flay"
require "rubycritic/core/smell"

module Rubycritic
  module Analyser

    class FlaySmells
      def initialize(analysed_modules)
        @analysed_modules = paths_to_analysed_modules(analysed_modules)
        @flay = Flay.new(@analysed_modules.keys)
      end

      def run
        @flay.hashes.each do |structural_hash, nodes|
          smell = create_smell(structural_hash, nodes)
          nodes.map(&:file).uniq.each do |file|
            @analysed_modules[file].smells << smell
          end

          nodes.each do |node|
            @analysed_modules[node.file].duplication += node.mass
          end
        end
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
          :locations => smell_locations(nodes),
          :context   => similarity(structural_hash),
          :message   => "found in #{nodes.size} nodes",
          :score     => mass,
          :type      => "DuplicateCode",
          :cost      => cost(mass)
        )
      end

      def smell_locations(nodes)
        nodes.map do |node|
          Location.new(node.file, node.line)
        end.sort
      end

      def similarity(structural_hash)
        if @flay.identical[structural_hash]
          "Identical code"
        else
          "Similar code"
        end
      end

      def cost(mass)
        mass / 25
      end
    end

  end
end
