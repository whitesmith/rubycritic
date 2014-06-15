require "code_analyzer"

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
        node.grep_nodes_count(sexp_type: [:def, :defs])
      end

      def parse_content(content)
        Sexp.from_array(Ripper::SexpBuilder.new(content).parse)[1]
      end
    end

  end
end
