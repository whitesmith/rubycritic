require 'test_helper'
require 'churn'
require 'churn/calculator'
describe "churn gem's Churn" do
  it 'computes how many times a file was changes' do
    config = {
      report: false, # Disable default report output
      start_date: '6 years ago', # Optional: Limit analysis to a specific time range
      minimum_churn_count: 1     # Minimum number of changes to consider a file
    }

    churn_calculator = ::Churn::ChurnCalculator.new(config)
    report = churn_calculator.report(false)
    assert_equal 146, report[:churn][:changes].length
  end
end
