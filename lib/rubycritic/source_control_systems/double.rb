# frozen_string_literal: true
module RubyCritic
  module SourceControlSystem
    class Double < Base
      def revisions_count(_)
        0
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
