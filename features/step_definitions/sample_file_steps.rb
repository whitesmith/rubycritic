# frozen_string_literal: true

Given(/^the smelly file 'smelly.rb'/) do
  contents = <<-RUBY.strip_heredoc
    class AllTheMethods
      def method_missing(method, *args, &block)
        message = "I"
        eval "message = ' did not'"
        eval "message << ' exist,'"
        eval "message << ' but now'"
        eval "message << ' I do.'"
        self.class.send(:define_method, method) { "I did not exist, but now I do." }
        self.send(method)
      end
    end
  RUBY
  write_file('smelly.rb', contents)
end

Given(/^the clean file 'clean.rb'/) do
  contents = <<-RUBY.strip_heredoc
    # Explanatory comment
    class Clean
      def foo; end
    end
  RUBY
  write_file('clean.rb', contents)
end

Given(/^the empty file 'empty.rb'/) do
  write_file('clean.rb', '')
end
