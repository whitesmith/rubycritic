module Rubycritic
  module SourceControlSystem

    class Double < Base
      def has_revision?
        false
      end

      def revisions_count(path)
        "N/A"
      end

      def date_of_last_commit(path)
        nil
      end
    end

  end
end
