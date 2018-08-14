require_relative 'integration_test_helper'

class NewTransactionFlowTest < MiniTest::Spec
  describe Sinatra::Application do
    it 'transactions index displays the correct heading' do
      visit '/transactions/all/1'
      assert page.has_content?("Catherine's Transactions")
    end

    it 'has a link to create a new transaction' do
      visit '/transactions/all/1'
      click_button 'New transaction'
      assert page.has_content?('New Transaction')
    end
  end
end
