require_relative 'helper_test'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @engine             = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @invoice_repository = @engine.invoice_repository
  end

  def test_repo_gets_populated
    assert_instance_of Invoice, @invoice_repository.repository[0], "0 not instance of invoice"
    assert_instance_of Invoice, @invoice_repository.repository[-1], "-1 not instance of invoice"
  end



  def test_create_invoice
    customer = @engine.customer_repository.find_by_id(7)
    merchant = @engine.merchant_repository.find_by_id(22)
    items    = (1..3).map { @engine.item_repository.random }
    invoice  = @invoice_repository.create(customer: customer,
                                          merchant: merchant,
                                          items: items
                                          )

    assert_instance_of Merchant, invoice.merchant
    assert_instance_of Customer, invoice.customer
    assert_equal merchant.id, invoice.merchant.id
    assert_equal customer.id, invoice.customer.id
  end

end
