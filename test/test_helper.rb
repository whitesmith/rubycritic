require "minitest/autorun"
require "minitest/pride"
require "mocha/setup"

def context(*args, &block)
  describe(*args, &block)
end
