require "minitest/autorun"
require "minitest/pride"
require "mocha/setup"
require "ostruct"

def context(*args, &block)
  describe(*args, &block)
end

def capture_output_streams
  $stdout = StringIO.new
  $stderr = StringIO.new
  yield
ensure
  $stdout = STDOUT
  $stderr = STDERR
end
