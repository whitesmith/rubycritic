require "minitest/autorun"
require "minitest/pride"
require "mocha/setup"
require "ostruct"

def context(*args, &block)
  describe(*args, &block)
end
