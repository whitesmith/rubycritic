module Rubycritic
  module SourceControlSystem
    class Double < Base
      def revisions_count(_)
        "N/A"
      end

      def date_of_last_commit(_)
        nil
      end

      def revision?
        false
      end
    end

  end
end
