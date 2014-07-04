require "ripper"
require "sexp_processor"

module Rubycritic
  module Analyser

    class Stats
      def initialize(analysed_files)
        @analysed_files = analysed_files
      end

      def stats
        @analysed_files.each do |analysed_file|
          analysed_file.methods_count = methods_count(analysed_file.path)
        end
      end

      private

      def methods_count(path)
        content = File.read(path)
        node = parse_content(content)
        node.count_nodes_of_type(:def, :defs)
      end

      def parse_content(content)
        Sexp.from_array(Ripper::SexpBuilder.new(content).parse)[1]
      end
    end

  end
end

class Sexp
  def count_nodes_of_type(*sexp_types)
    count = 0
    recursive_children do |child|
      count += 1 if sexp_types.include?(child.sexp_type)
    end
    count
  end

  def recursive_children
    children.each do |child|
      yield child
      child.recursive_children { |grand_child| yield grand_child }
    end
  end

  def children
    find_all { | sexp | Sexp === sexp }
  end
end
