# frozen_string_literal: true

require 'fakefs/safe'

module FakeFS
  class File < StringIO
    def flock(*)
      true
    end
  end
end
