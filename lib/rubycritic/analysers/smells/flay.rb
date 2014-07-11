require "rubycritic/analysers/adapters/flay"
require "rubycritic/core/smell"

module Rubycritic
  module Analyser

    class FlaySmells
      def initialize(analysed_files)
        @analysed_files = paths_to_analysed_files(analysed_files)
        @flay = Flay.new(@analysed_files.keys)
      end

      def run
        @flay.hashes.each do |structural_hash, nodes|
          smell = create_smell(structural_hash, nodes)
          nodes.map(&:file).uniq.each do |file|
            @analysed_files[file].smells << smell
          end

          nodes.each do |node|
            @analysed_files[node.file].duplication += node.mass
          end
        end
      end

      private

      def paths_to_analysed_files(analysed_files)
        paths = {}
        analysed_files.each do |analysed_file|
          paths[analysed_file.path] = analysed_file
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
