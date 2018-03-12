# frozen_string_literal: true

module RubyCritic
  module SourceControlSystem
    class Double < Base
      def revisions_count(_path)
        0
      end

      def date_of_last_commit(_path)
        nil
      end

      def revision?
        false
      end
    end
  end
end
