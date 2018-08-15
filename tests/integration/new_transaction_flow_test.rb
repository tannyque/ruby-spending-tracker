require_relative 'integration_helper'

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

    it 'has a new transaction page with form' do
      visit '/transactions/new/1'
      assert page.has_content?('New Transaction')
      assert page.has_content?('Amount')
      assert page.has_content?('Please select a merchant')
      assert page.has_content?('Transaction categories')
    end
  end
end
