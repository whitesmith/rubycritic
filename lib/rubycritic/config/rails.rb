module Rubycritic
  module Config
    class Rails < Base

      def set(options)
        super(options)
        self.root = '.'
        self.format = :rails
        self.open_with = nil
        self.no_browser = true
      end

    end
  end
end