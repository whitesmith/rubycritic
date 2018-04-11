# frozen_string_literal: true

require 'test_helper'
require 'rubycritic/browser'

describe RubyCritic::Browser do
  before do
    @report_path = 'tmp/rubycritic/overview.html'
    @browser = RubyCritic::Browser.new @report_path
  end

  describe '#open' do
    it 'should be open report with launch browser' do
      Launchy.stubs(:open).returns(true)
      @browser.open.must_equal true
    end
  end
end
