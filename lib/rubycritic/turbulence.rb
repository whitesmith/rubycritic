require "rubycritic/analysers/churn"
require "rubycritic/analysers/flog"
require "rubycritic/quality_adapters/flog"

module Rubycritic

  class Turbulence
    def initialize(paths, source_control_system)
      @paths = paths
      @source_control_system = source_control_system
    end

    def data
      @paths.zip(churn, complexity).map do |path_info|
        {
          name: path_info[0],
          x: path_info[1],
          y: path_info[2]
        }
      end
    end

    def churn
      @churn ||= Analyser::Churn.new(@paths, @source_control_system).churn
    end

    def complexity
      @complexity ||= QualityAdapter::Flog.new(@paths).complexity
    end
  end

end
