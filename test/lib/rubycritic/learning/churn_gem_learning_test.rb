require 'test_helper'
require 'churn'
require 'churn/calculator'
require 'byebug'
describe "churn gem's Churn" do
  it 'computes how many times a file was changed' do
    config = {
      report: false, # Disable default report output
      start_date: '6 years ago', # Optional: Limit analysis to a specific time range
      minimum_churn_count: 1     # Minimum number of changes to consider a file
    }
    Churn::GitAnalyzer.stubs(:supported?).returns(true)
    churn_calculator = ::Churn::ChurnCalculator.new(config)
    report = churn_calculator.report(false)

    changes = report[:churn][:changes].first
    assert changes.has_key?(:file_path)
    assert changes.has_key?(:times_changed)
  end
end
