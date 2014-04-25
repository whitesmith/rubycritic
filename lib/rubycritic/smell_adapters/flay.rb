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
        is_identical = @flay.identical[structural_hash]
        similarity   = is_identical ? "Identical" : "Similar"

        locations = smell_locations(nodes)
        context   = "#{similarity} code"
        message   = "found in #{nodes.size} nodes"
        score     = @flay.masses[structural_hash]

        Smell.new(
          :locations => locations,
          :context => context,
          :message => message,
          :score => score,
          :type => "DuplicateCode"
        )
      end

      def smell_locations(nodes)
        nodes.map do |node|
          Location.new(node.file, node.line)
        end.sort
      end
    end

  end
end
