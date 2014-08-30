module Rubycritic
  module SourceControlSystem

    class Double < Base
      def revisions_count(path)
        "N/A"
      end

      def date_of_last_commit(path)
        nil
      end

      def has_revision?
        false
      end
    end

  end
end
