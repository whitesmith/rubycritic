# frozen_string_literal: true

require 'rubycritic/source_locator'
require 'rubycritic/core/analysed_module'

module RubyCritic
  class AnalysedModulesCollection
    include Enumerable

    # Limit used to prevent very bad modules to have excessive impact in the
    # overall result. See #limited_cost_for
    COST_LIMIT = 32.0
    # Score goes from 0 (worst) to 100 (perfect)
    MAX_SCORE = 100.0
    # Projects with an average cost of 16 (or above) will score 0, since 16
    # is where the worst possible rating (F) starts
    ZERO_SCORE_COST = 16.0
    COST_MULTIPLIER = MAX_SCORE / ZERO_SCORE_COST

    def initialize(paths, modules = nil)
      @modules = SourceLocator.new(paths).pathnames.map do |pathname|
        if modules
          analysed_module = modules.find { |mod| mod.pathname == pathname }
          build_analysed_module(analysed_module)
        else
          AnalysedModule.new(pathname: pathname)
        end
      end
    end

    def each(&block)
      @modules.each(&block)
    end

    def where(module_paths)
      @modules.find_all { |mod| module_paths.include? mod.path }
    end

    def find(module_path)
      @modules.find { |mod| mod.pathname == module_path }
    end

    def to_json(*options)
      @modules.to_json(*options)
    end

    def score
      if @modules.any?
        (MAX_SCORE - average_limited_cost * COST_MULTIPLIER).round(2)
      else
        0.0
      end
    end

    def summary
      AnalysisSummary.generate(self)
    end

    def for_rating(rating)
      find_all { |mod| mod.rating.to_s == rating }
    end

    private

    def average_limited_cost
      [average_cost, ZERO_SCORE_COST].min
    end

    def average_cost
      num_modules = @modules.size
      if num_modules.positive?
        map { |mod| limited_cost_for(mod) }.reduce(:+) / num_modules.to_f
      else
        0.0
      end
    end

    def limited_cost_for(mod)
      [mod.cost, COST_LIMIT].min
    end

    def build_analysed_module(analysed_module)
      AnalysedModule.new(
        pathname: analysed_module.pathname,
        name: analysed_module.name,
        smells: analysed_module.smells,
        churn: analysed_module.churn,
        committed_at: analysed_module.committed_at,
        complexity: analysed_module.complexity,
        duplication: analysed_module.duplication,
        methods_count: analysed_module.methods_count
      )
    end
  end
end
