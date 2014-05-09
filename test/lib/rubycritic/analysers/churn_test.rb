require "test_helper"
require "rubycritic/analysers/churn"
require "rubycritic/source_control_systems/source_control_system"

describe Rubycritic::Analyser::Churn do
  before do
    sample_paths = ["path_to_some_file.rb"]
    source_control_system = SourceControlSystemDouble.new
    @churn = Rubycritic::Analyser::Churn.new(sample_paths, source_control_system)
  end

  describe "#churn" do
    it "returns an array containing the number of times each file has changed" do
      @churn.churn.must_equal [1]
    end
  end
end

class SourceControlSystemDouble < Rubycritic::SourceControlSystem
  def revisions_count(file)
    1 # churn
  end
end
