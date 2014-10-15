require_relative 'helper_test'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository, :engine

  def setup
    @engine             = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @invoice_repository = InvoiceRepository.new(SalesEngine.new, "data")
  end

  def test_repo_gets_populated
    assert_instance_of Invoice, engine.invoice_repository.repository[0], "0 not instance of invoice"
    assert_instance_of Invoice, engine.invoice_repository.repository[-1], "-1 not instance of invoice"
  end

  def test_create_invoice_create
    customer = engine.customer_repository.find_by_id(7)
    merchant = engine.merchant_repository.find_by_id(22)
    items    = (1..3).map { @engine.item_repository.random }
    invoice  = engine.invoice_repository.create(customer: customer,
                                          merchant: merchant,
                                          items: items
                                          )

    assert_instance_of Merchant, invoice.merchant
    assert_instance_of Customer, invoice.customer
    assert_equal merchant.id, invoice.merchant.id
    assert_equal customer.id, invoice.customer.id
  end

  def test_it_has_a_repository
    invoice_repository.make_repo
    assert invoice_repository.repository
  end

  def test_it_exists
    assert invoice_repository
  end

  def test_it_has_a_sales_engine
    assert engine.invoice_repository
  end

  def test_it_returns_all_invoice_items
    assert invoice_repository.repository
    invoice_repository.make_repo
    invoice = invoice_repository.repository.first
    assert_equal "shipped", invoice.status.to_s
    assert_equal "1", invoice.id.to_s
  end
end
