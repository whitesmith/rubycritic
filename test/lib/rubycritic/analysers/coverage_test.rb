# frozen_string_literal: true

require 'analysers_test_helper'
require 'rubycritic/analysers/coverage'
require 'rubycritic/source_control_systems/base'
require 'fakefs_helper'

describe RubyCritic::Analyser::Coverage do
  describe '#run' do
    let(:simplecov_version_dir) do
      if Gem.loaded_specs['simplecov'].version >= Gem::Version.new('0.21')
        '0.21'
      else
        '0.18'
      end
    end
    let(:coverage_path) do
      File.join(PathHelper.project_path, 'test', 'samples', 'coverage_sample', simplecov_version_dir)
    end
    let(:resultset_file) do
      File.join(coverage_path, '.resultset.json')
    end
    let(:old_content) do
      File.read(resultset_file)
    end

    before do
      with_cloned_fs do
        SimpleCov.root(PathHelper.project_path)
        new_content = old_content.gsub('[REPLACE_ME]', PathHelper.project_path)
        File.write(resultset_file, new_content)
        SimpleCov.coverage_dir(coverage_path)
        @analysed_module = AnalysedModuleDouble.new(path: path)
        @analysed_modules = [@analysed_module]
        analyser = RubyCritic::Analyser::Coverage.new(@analysed_modules)
        analyser.run
      end
    end

    context 'when analysing a file with no test coverage' do
      let(:path) { 'some_file.rb' }

      it 'calculates its test coverage as 0' do
        _(@analysed_module.coverage).must_equal 0
      end
    end

    context 'when analysing a file with some test coverage' do
      let(:path) { 'lib/rubycritic/source_control_systems/double.rb' }

      it 'calculates its test coverage' do
        _(@analysed_module.coverage).must_equal 75
      end
    end
  end
end
