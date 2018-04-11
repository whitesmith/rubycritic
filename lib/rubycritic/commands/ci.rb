# frozen_string_literal: true

require 'rubycritic/source_control_systems/base'
require 'rubycritic/analysers_runner'
require 'rubycritic/reporter'
require 'rubycritic/commands/default'
require 'rubycritic/commands/compare'

module RubyCritic
  module Command
    class Ci < Compare
    end
  end
end
