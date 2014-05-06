require "rubycritic/smell"

module Rubycritic
  module SmellAdapter

    class Flay
      def initialize(flay)
        @flay = flay
      end

      def smells
        @flay.hashes.map do |structural_hash, nodes|
          create_smell(structural_hash, nodes)
        end
      end

      private

      def create_smell(structural_hash, nodes)
        Smell.new(
          :locations => smell_locations(nodes),
          :context   => "#{similarity(structural_hash)} code",
          :message   => "found in #{nodes.size} nodes",
          :score     => @flay.masses[structural_hash],
          :type      => "DuplicateCode"
        )
      end

      def smell_locations(nodes)
        nodes.map do |node|
          Location.new(node.file, node.line)
        end.sort
      end

      def similarity(structural_hash)
        if @flay.identical[structural_hash]
          "Identical"
        else
          "Similar"
        end
      end
    end

  end
end
