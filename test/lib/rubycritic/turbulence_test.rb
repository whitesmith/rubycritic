require "test_helper"
require "rubycritic/turbulence"
require "rubycritic/source_control_systems/source_control_system"

describe Rubycritic::Turbulence do
  before do
    @sample_path = "test/samples/flog/smelly.rb"
    @sample_paths = [@sample_path]
    @source_control_system = SourceControlSystemDouble.new
  end

  describe "#data" do
    it "returns an array of hashes containing the path, churn and complexity of each file" do
      data = Rubycritic::Turbulence.new(@sample_paths, @source_control_system).data
      data_instance = data.first
      data_instance[:name].must_equal @sample_path
      data_instance[:x].must_equal 1 # churn
      data_instance[:y].must_be_kind_of Numeric # complexity
    end
  end
end

class SourceControlSystemDouble < Rubycritic::SourceControlSystem
  def revisions_count(file)
    1 # churn
  end
end
