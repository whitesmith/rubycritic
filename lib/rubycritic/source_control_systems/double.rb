module Rubycritic
  module SourceControlSystem

    class Double < Base
      def revisions_count(file)
        "N/A"
      end

      def has_revision?
        false
      end
    end

  end
end
