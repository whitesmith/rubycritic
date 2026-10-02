# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require 'fileutils'
require 'yaml'
require 'rubycritic/cli/options/file'

describe RubyCritic::Cli::Options::File do
  before do
    @dir = Dir.mktmpdir('rubycritic-file-options-')
  end

  after do
    FileUtils.remove_entry(@dir) if @dir && File.directory?(@dir)
  end

  def options_for(config)
    path = File.join(@dir, '.rubycritic.yml')
    File.write(path, YAML.dump(config))
    options = RubyCritic::Cli::Options::File.new(path)
    options.parse
    options
  end

  def capture_stderr
    original = $stderr
    $stderr = StringIO.new
    yield
    $stderr.string
  ensure
    $stderr = original
  end

  describe 'maximum_decrease YAML key' do
    it 'reads a float maximum_decrease value' do
      options = options_for('maximum_decrease' => 0.5)

      _(options.to_h[:threshold_score]).must_equal 0.5
    end

    it 'does not emit a deprecation warning for the canonical key' do
      options = options_for('maximum_decrease' => 0.5)

      warning = capture_stderr { options.to_h }

      _(warning).must_equal ''
    end
  end

  describe 'legacy threshold_score YAML key' do
    it 'is still honoured for backward compatibility' do
      options = options_for('threshold_score' => 0.5)

      result = nil
      capture_stderr { result = options.to_h }

      _(result[:threshold_score]).must_equal 0.5
    end

    it 'emits a deprecation warning pointing to maximum_decrease' do
      options = options_for('threshold_score' => 10)

      warning = capture_stderr { options.to_h }

      _(warning).must_include 'DEPRECATION'
      _(warning).must_include 'threshold_score'
      _(warning).must_include 'maximum_decrease'
    end
  end

  describe 'when both keys are present' do
    it 'prefers the canonical maximum_decrease key' do
      options = options_for('maximum_decrease' => 0.5, 'threshold_score' => 10)

      result = nil
      capture_stderr { result = options.to_h }

      _(result[:threshold_score]).must_equal 0.5
    end

    it 'still warns about the deprecated threshold_score key' do
      options = options_for('maximum_decrease' => 0.5, 'threshold_score' => 10)

      warning = capture_stderr { options.to_h }

      _(warning).must_include 'DEPRECATION'
    end
  end
end
