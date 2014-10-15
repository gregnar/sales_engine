require_relative "helper_test"
require './lib/invoice'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
  end

  def test_charge
    invoice = @engine.invoice_repository.find_by_id(3)
    prior_transaction_count = invoice.transactions.count
    invoice.charge(credit_card_number: '1111222233334444',
                  credit_card_expiration_date: "10/14",
                  result: "success")

    invoice = @engine.invoice_repository.find_by_id(invoice.id)
    assert_equal prior_transaction_count, invoice.transactions.count
  end

end
