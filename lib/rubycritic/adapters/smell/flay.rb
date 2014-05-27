require "rubycritic/analysers/flay"
require "rubycritic/core/smell"

module Rubycritic
  module SmellAdapter

    class Flay
      def initialize(analysed_files)
        @analysed_files = analysed_files
        @flay = Analyser::Flay.new(analysed_files.map(&:path))
        @smells = Hash.new { |hash, key| hash[key] = [] }
      end

      def smells
        find_smells
        add_smells_to_analysed_files
      end

      private

      def find_smells
        @flay.hashes.each do |structural_hash, nodes|
          smell = create_smell(structural_hash, nodes)
          nodes.map(&:file).uniq.each do |file|
            @smells[file] << smell
          end
        end
      end

      def add_smells_to_analysed_files
        @analysed_files.each do |analysed_file|
          analysed_file.smells += @smells[analysed_file.path]
        end
      end

      def create_smell(structural_hash, nodes)
        Smell.new(
          :locations => smell_locations(nodes),
          :context   => "#{similarity(structural_hash)} code",
          :message   => "found in #{nodes.size} nodes",
          :score     => @flay.masses[structural_hash],
          :type      => "DuplicateCode",
          :cost      => 2
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
